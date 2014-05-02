define [
  'chaplin'
  'views/site_view'
  'views/navbar_view'
  'views/logo_view'
], (Chaplin, SiteView, NavbarView, LogoView) ->
  'use strict'

  class Controller extends Chaplin.Controller
    beforeAction: ->
      super
      @reuse 'site', SiteView
      @reuse 'navbar', NavbarView, region: 'navbar'
      @reuse 'logo', LogoView, region: 'navbar_left'
