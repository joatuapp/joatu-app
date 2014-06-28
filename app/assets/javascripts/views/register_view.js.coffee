define [
  'chaplin'
  'views/base/view'
  'views/register_step1_view'
  'views/register_step2_view'
  'views/register_step3_view'
  'models/flash'
  'views/flash_view'
  'backbone-validation'
], (Chaplin, View, RegisterStep1View, RegisterStep2View, RegisterStep3View, Flash, FlashView) ->
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
      @delegate('click', '[role=tab]', @selectTab)

    render: ->
      super
      step1 = new RegisterStep1View autoRender: true, region: 'step1'
      @subview 'step1', step1
      step2 = new RegisterStep2View autoRender: true, region: 'step2'
      @subview 'step2', step2

      Backbone.Validation.bind(@)
      @modelBinder.bind(@model, @$el)

    dispose: ->
      Backbone.Validation.unbind(@)
      super

    register: (event) ->
      event.preventDefault()
      request = @model.save()
      request.done(=>
        @publishEvent '!createSession', @model
        Chaplin.utils.redirectTo name: 'root'
      )
      request.fail(=>
        @displayFormError()
        # TODO: Handle server side failure.
        # should only need to cover connection issues
        # as data should (normally) be 
        # validated client side.
      )

    selectTab: (event) ->
      event.preventDefault()
      if @model.isValid(true)
        $(event.currentTarget).tab('show')
      else
        @displayFormError()

    displayFormError: ->
      model = new Flash(message: "Please fix the errors on the form.")
      flash = new FlashView(container: @$('.register-flash'), model: model)
      @subview 'flash', flash
