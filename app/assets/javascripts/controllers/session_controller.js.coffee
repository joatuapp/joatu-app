define [
  'chaplin'
  'controllers/base/controller'
  'models/user'
  'views/login_view'
  'views/modal_view'
  'lib/utils'
], (Chaplin, Controller, User, LoginView, ModalView, utils) ->
  'use strict'

  class SessionController extends Controller

    loginView: null

    initialize: ->
      @subscribeEvent '!showLogin', @showLoginView
      @subscribeEvent '!requireLogin', @requireLogin
      @subscribeEvent '!createSession', @createSession
      @subscribeEvent '!logout', @logout

      # Determine current logged-in state
      @initSession()

    initSession: ->
      if !Chaplin.mediator.user && auth_token = utils.sessionStorage('authentication_token')
        user = new User
        user.set authentication_token: auth_token
        Chaplin.mediator.user = user

        userDataRequest = $.ajax
          type: 'get'
          url: user.urlRoot() + '/me'
          headers: {
            "Authorization": "Token token=" + auth_token
          }
        userDataRequest.done (data) =>
          user.set(data)
          @publishEvents()
      else
        @publishEvents()

    createSession: (user) ->
      Chaplin.mediator.user = user
      @publishEvents()
      utils.sessionStorage('authentication_token', user.get('authentication_token'))

    logout: =>
      @destroySession()
      @publishEvents()
      Chaplin.utils.redirectTo name: 'root'

    requireLogin: ->
      unless Chaplin.mediator.user
        @showLoginView()

    showLoginView: ->
      return if @loginModalView
      user = new User
      loginView = new LoginView model: user
      @loginModalView = new ModalView content: loginView, className: 'modal modal-login', autoRender: true
      @loginModalView.delegate('hidden.bs.modal', @disposeLoginModalView)

    destroySession: ->
      @disposeUser()
      utils.sessionStorageRemove('authentication_token')

    publishEvents: ->
      if Chaplin.mediator.user
        Chaplin.mediator.publish 'login', Chaplin.mediator.user 
        Chaplin.mediator.publish 'loginStatus', true
      else
        Chaplin.mediator.publish 'loginStatus', false

    disposeLoginModalView: =>
      return unless @loginModalView
      @loginModalView.dispose()
      @loginModalView = null

    disposeUser: =>
      return unless Chaplin.mediator.user
      Chaplin.mediator.user.dispose()
      Chaplin.mediator.user = null

