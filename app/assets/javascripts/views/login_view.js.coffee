define [
  'views/base/view'
  'views/flash_view'
], (View, FlashView) ->
  'use strict'

  class LoginView extends View
    className: ''
    autoRender: true
    templateName: 'login_form'

    initialize: (options) ->
      super
      @delegate('submit', 'form', @login)

    render: ->
      super
      # NOTE: Not using validation, as it will
      # (correctly) fail for login. Not really
      # needed anyway.
      @modelBinder.bind(@model, @$el)

    dispose: ->
     @modelBinder.unbind()
     super

    login: (event) ->
      event.preventDefault()
      @model.sign_in(success: @loginSuccess, error: @loginError) 

    loginSuccess: (model, response, options) =>
      @model.set(response)
      @publishEvent '!createSession', model
      @closeIfModal()

    loginError: (model, response, options) =>
      if response.status == 401
        message = if response.responseJSON.error then response.responseJSON.error else "Invalid username or password."
      else
        message = "Login Error."
      error = new FlashView message: message, container: $(@el).find('.errors')
      @subview 'error', error
