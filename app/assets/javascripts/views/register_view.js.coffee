define [
  'views/base/view'
  'views/register_step1_view'
  'views/register_step2_view'
  'views/register_step3_view'
  'models/user'
  'form2js'
], (View, RegisterStep1View, RegisterStep2View, RegisterStep3View, User, form2js, template) ->
  'use strict'

  class RegisterView extends View
    templateName: 'register'
    className: 'row register'

    regions:
      step1: "#step1"
      step2: "#step2"
      step3: "#step3"

    initialize: (options) ->
      super
      @delegate('submit', 'form', @register)
      @delegate('click', 'button[data-toggle=tab]', @selectTab)
      @subscribeEvent 'registerErrors', @displayRegisterErrors

    attach: ->
      super
      step1 = new RegisterStep1View autoRender: true, region: 'step1'
      @subview 'step1', step1
      step2 = new RegisterStep2View autoRender: true, region: 'step2'
      @subview 'step2', step2

    register: (event) ->
      event.preventDefault()
      user = new User
      if user.save(form2js(event.currentTarget, '.', true))
        @publishEvent '!createSession', user
        Chaplin.utils.redirectTo name: 'root'
      else
        @displayRegisterErrors(user.errors)

    displayRegisterErrors: (error_data) ->
      for field, error of error_data
        input = $('[name='+field+']')
        formgroup = input.closest('.form-group')
        icon = $('<span/>', {
          class: 'glyphicon glyphicon-remove form-control-feedback'
        })
        error_message = $('<span/>', {
          class: 'help-block',
          text: error[0]
        })
        formgroup.addClass('has-error')
        error_message.insertAfter(input)
        icon.insertAfter(input)
        input.on('focus', @removeError)

    removeError: (event) ->
      formgroup = $(event.currentTarget).closest('.form-group')
      formgroup.removeClass('has-error')
      formgroup.find('.form-control-feedback').remove()
      formgroup.find('.help-block').remove()
      $(event.currentTarget).off('focus', @removeError)

    selectTab: (event) ->
      newStep = $(event.currentTarget).attr('data-target').substring(1)
      $('.register-steps .step').removeClass('active')
      $('.register-steps .'+ newStep).addClass('active')
