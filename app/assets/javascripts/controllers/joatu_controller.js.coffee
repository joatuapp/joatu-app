define [
  'controllers/base/controller'
  'models/hello_world'
  'views/hello_world_view'
], (Controller, HelloWorld, HelloWorldView) ->
  'use strict'

  class JoatuController extends Controller

    title: 'JoatU'

    historyURL: (params) ->
      ''

    show: (params) ->
      @model = new HelloWorld()
      @view = new HelloWorldView model: @model
