define [
  'chaplin'
  'controllers/base/controller'
  'models/user'
  'views/login_view'
  'lib/utils'
], (Chaplin, Controller, User, LoginView, utils) ->
  'use strict'

  class SessionController extends Controller

    loginView: null

    initialize: ->
      @subscribeEvent '!showLogin', @showLoginView
      @subscribeEvent '!requireLogin', @requireLogin
      @subscribeEvent '!login', @login
      @subscribeEvent '!register', @register
      @subscribeEvent '!logout', @logout

      # Determine current logged-in state
      @initSession()

    initSession: ->
      if auth_token = utils.sessionStorage('authentication_token')
        userDataRequest = $.ajax
          type: 'get'
          url: Chaplin.mediator.base_url + '/users/me'
          headers: {
            "Authorization": "Token token=" + auth_token
          }

        userDataRequest.done (data) =>
          @updateUser data

      @updateLogin()

    login: (loginData) ->
      loginRequest = $.ajax
        type: 'post'
        url: Chaplin.mediator.api_base_url + '/users/sign_in'
        data: JSON.stringify(loginData)
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        }

      loginRequest.done (data) =>
        @disposeLoginView()
        @createSession data
        @updateLogin()

    register: (registerData) ->
      registerRequest = $.ajax
        type: 'post'
        url: Chaplin.mediator.api_base_url + '/users'
        data: JSON.stringify(registerData)
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        }

      registerRequest.done (data) =>
        @createSession data
        @updateLogin()
        Chaplin.utils.redirectTo name: 'root'

      registerRequest.fail (data) =>
        @publishEvent 'registerErrors', data.responseJSON.errors

    logout: =>
      @destroySession()
      @updateLogin()
      Chaplin.utils.redirectTo name: 'root'

    requireLogin: ->
      unless Chaplin.mediator.user
        @showLoginView()

    showLoginView: ->
      return if @loginView
      @loginView = new LoginView
      @loginView.delegate('hidden.bs.modal', '.modal', @disposeLoginView)

    createSession: (sessionData) ->
      @updateUser sessionData
      utils.sessionStorage('authentication_token', sessionData.authentication_token)

    destroySession: ->
      @disposeUser()
      utils.sessionStorageRemove('authentication_token')

    updateLogin: ->
      if Chaplin.mediator.user
        Chaplin.mediator.publish 'login', Chaplin.mediator.user 
        Chaplin.mediator.publish 'loginStatus', true
      else
        Chaplin.mediator.publish 'loginStatus', false
        @logout

    updateUser: (userData) ->
      if Chaplin.mediator.user
        Chaplin.mediator.user.set userData
      else
        Chaplin.mediator.user = new User userData

    disposeLoginView: =>
      return unless @loginView
      @loginView.dispose()
      @loginView = null

    disposeUser: =>
      return unless Chaplin.mediator.user
      Chaplin.mediator.user.dispose()
      Chaplin.mediator.user = null

