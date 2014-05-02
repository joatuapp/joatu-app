define [
  'views/base/view'
  'views/logged_in_menubar_view'
  'views/logged_out_menubar_view'
], (View, LoggedInMenubarView, LoggedOutMenubarView, template) ->
  'use strict'

  class NavbarView extends View
    initialize: (options) ->
      super
      @subscribeEvent 'loginStatus', @loginStatusChange

    className: 'container'
    regions:
      navbar_center: '#navbar-center'
      navbar_right: '#navbar-right'
    templateName: 'navbar'

    loginStatusChange: (status) ->
      if status
        menubarView = new LoggedInMenubarView autorender: true, region: 'navbar_right'
      else
        menubarView = new LoggedOutMenubarView autorender: true, region: 'navbar_right'
      @subview 'menubar', menubarView
      menubarView.render()
