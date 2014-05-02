define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class LoggedOutMenubarView extends View
    templateName: 'logged_out_menubar'
    className: 'logged-out-menubar'
