define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class LoggedInMenubarView extends View
    templateName: 'logged_in_menubar'
    className: 'collapse navbar-collapse'
    id: 'top-navbar'
