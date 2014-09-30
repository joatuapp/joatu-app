define [
  'chaplin'
  'controllers/base/controller'
  'models/user'
  'views/register_view'
  'controllers/session_controller'
], (Chaplin, Controller, User, RegisterView, SessionController) ->
  'use strict'

  class RegisterController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    show: ->
      @user = new User
      @view = new RegisterView model: @user, region: 'main'
      @view.render()

    confirm: (params) ->
      @user = new User

      confirmRequest = $.ajax
        type: 'post'
        url: @user.urlRoot() + '/confirmation'
        data: { "confirmation_token": params["confirmation_token"] }
      confirmRequest.done (data) =>
        @user.set(data)
        @publishEvent '!createSession', @user
        @redirectTo('root')
      confirmRequest.fail (data) =>
        @redirectTo('root')
