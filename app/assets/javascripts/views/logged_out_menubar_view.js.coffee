define [
  'chaplin'
  'views/base/view'
], (Chaplin, View, template) ->
  'use strict'

  class LoggedOutMenubarView extends View
    templateName: 'logged_out_menubar'
    className: 'logged-out-menubar'

    initialize: (options) ->
      super
      @delegate('click', '[data-action=login]', @login)
      @delegate('click', '[data-action=register]', @register)

    login: ->
      event.preventDefault()
      Chaplin.utils.redirectTo name: 'login'

    register: ->
      event.preventDefault()
      Chaplin.utils.redirectTo name: 'register'
