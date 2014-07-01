define [
  'controllers/base/controller'
  'views/home_view'
  'controllers/session_controller'
], (Controller, HomeView, SessionController) ->
  'use strict'

  class HomeController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    title: 'What are you looking for?'

    historyURL: (params) ->
      ''

    show: (params) ->
      @view = new HomeView region: 'main', autoRender: true
