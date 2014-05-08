define [
  'views/base/view'
  'views/register_step1_view'
  'views/register_step2_view'
  'views/register_step3_view'
  'form2js'
], (View, RegisterStep1View, RegisterStep2View, RegisterStep3View, form2js, template) ->
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

    render: ->
      super
      step1 = new RegisterStep1View autoRender: true, region: 'step1'
      @subview 'step1', step1
      step2 = new RegisterStep2View autoRender: true, region: 'step2'
      @subview 'step2', step2
      step3 = new RegisterStep3View autoRender: true, region: 'step3'
      @subview 'step3', step3

    register: (event) ->
      event.preventDefault()
      data = form2js(event.currentTarget, '.', true)
      @publishEvent '!register', data
