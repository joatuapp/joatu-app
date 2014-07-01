define [
  'controllers/base/controller'
  'models/user'
  'views/profile_view'
  'controllers/session_controller'
], (Controller, User, ProfileView, SessionController) ->
  'use strict'

  class UserController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    title: 'Profile'

    show: (params) ->
      @model = new User(id: params["id"])
      @view = new ProfileView model: @model, region: 'main', autoRender: true
      @model.fetch()
