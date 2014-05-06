define [
  'views/base/view'
  'form2js'
], (View, form2js, template) ->
  'use strict'

  class LoginView extends View
    className: ''
    autoRender: true
    region: 'modal'
    templateName: 'login_modal'

    initialize: (options) ->
      super
      @delegate('submit', 'form', @login)

    attach: ->
      super
      if @region == 'modal'
        $(@el).find('.modal').modal 'show'

    login: (event) ->
      event.preventDefault()
      data = form2js(event.currentTarget, '.', true)
      @publishEvent '!login', data
