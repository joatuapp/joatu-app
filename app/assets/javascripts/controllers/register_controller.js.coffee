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

