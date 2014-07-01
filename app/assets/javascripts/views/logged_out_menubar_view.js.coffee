define [
  'chaplin'
  'views/base/view'
], (Chaplin, View, template) ->
  'use strict'

  class LoggedOutMenubarView extends View
    templateName: 'logged_out_menubar'
    className: 'collapse navbar-collapse'
    id: 'top-navbar'

    initialize: (options) ->
      super
      @delegate('click', '[data-action=login]', @login)
      @delegate('click', '[data-action=register]', @register)

    login: ->
      event.preventDefault()
      @publishEvent '!showLogin'

    register: ->
      event.preventDefault()
      Chaplin.utils.redirectTo name: 'register'
