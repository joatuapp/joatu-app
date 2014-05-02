define [
  'controllers/base/controller'
  'models/hello_world'
  'views/hello_world_view'
  'controllers/session_controller'
], (Controller, HelloWorld, HelloWorldView, SessionController) ->
  'use strict'

  class JoatuController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    title: 'JoatU'

    historyURL: (params) ->
      ''

    show: (params) ->
      @model = new HelloWorld()
      @view = new HelloWorldView model: @model
