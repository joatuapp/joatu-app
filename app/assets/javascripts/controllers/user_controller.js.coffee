define [
  'controllers/base/controller'
  'models/user'
  'views/profile_view'
  'views/profile_edit_view'
  'controllers/session_controller'
], (Controller, User, ProfileView, ProfileEditView, SessionController) ->
  'use strict'

  class UserController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    title: 'Profile'

    show: (params) ->
      @model = new User(id: params["id"])
      @model.fetch()
      @view = new ProfileView model: @model, region: 'main', autoRender: true

    edit: (params) ->
      @model = new User(id: params["id"])
      @model.fetch()
      @view = new ProfileEditView model: @model, region: 'main', autoRender: true
