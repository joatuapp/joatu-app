define [
  'controllers/base/controller'
  'views/about_view'
  'controllers/session_controller'
], (Controller, AboutView, SessionController) ->
  'use strict'

  class AboutController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    title: 'What are you looking for?'

    historyURL: (params) ->
      ''

    show: (params) ->
      @view = new AboutView region: 'main', autoRender: true
