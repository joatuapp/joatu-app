define [
  'views/base/view'
  'views/flash_view'
  'models/user'
  'models/flash'
  'form2js'
], (View, FlashView, User, Flash, form2js, template) ->
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
      user = new User
      user.set(form2js(event.currentTarget, '.', true))
      user.sign_in(success: @loginSuccess, error: @loginError) 

    loginSuccess: (model, response, options) =>
      model.set(response)
      @publishEvent '!createSession', model
      $(@el).find('.modal').modal 'hide'

    loginError: (model, response, options) =>
      if response.status == 401
        message = new Flash message: "Invalid username or password."
      else
        message = new Flash message: "Login Error."
      error = new FlashView model: message, container: $(@el).find('.errors')
      @subview 'error', error
