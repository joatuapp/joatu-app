define [
  'chaplin'
  'controllers/base/controller'
  'models/user'
  'views/register_step1_view'
  'controllers/session_controller'
], (Chaplin, Controller, User, RegisterStep1View, SessionController) ->
  'use strict'

  class RegisterController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    step1: ->
      @user = new User
      @view = new RegisterStep1View model: @user, region: 'main'
      @view.render()
