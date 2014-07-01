define [
  'views/base/view'
  'views/flash_view'
  'models/flash'
], (View, FlashView, Flash) ->
  'use strict'

  class LoginView extends View
    className: ''
    autoRender: true
    region: 'modal'
    templateName: 'login_modal'

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

    attach: ->
      super
      if @region == 'modal'
        $(@el).find('.modal').modal 'show'

    login: (event) ->
      event.preventDefault()
      @model.sign_in(success: @loginSuccess, error: @loginError) 

    loginSuccess: (model, response, options) =>
      @model.set(response)
      @publishEvent '!createSession', model
      $(@el).find('.modal').modal 'hide'

    loginError: (model, response, options) =>
      if response.status == 401
        msg_content = if response.responseJSON.error then response.responseJSON.error else "Invalid username or password."
        message = new Flash message: msg_content
      else
        message = new Flash message: "Login Error."
      error = new FlashView model: message, container: $(@el).find('.errors')
      @subview 'error', error
