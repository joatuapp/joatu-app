define [
  'chaplin'
  'views/site_view'
  'views/navbar_view'
], (Chaplin, SiteView, NavbarView) ->
  'use strict'

  class Controller extends Chaplin.Controller
    beforeAction: ->
      super
      @reuse 'site', SiteView
      @reuse 'navbar', NavbarView, region: 'navbar'
