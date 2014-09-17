define [
  'chaplin'
  'views/base/view'
  'views/register_step1_view'
  'views/register_step2_view'
  'views/register_step3_view'
  'views/flash_view'
  'backbone-validation'
], (Chaplin, View, RegisterStep1View, RegisterStep2View, RegisterStep3View, FlashView) ->
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
      @listenTo @model, "validated:valid", @hideFormError

    render: ->
      super
      step1 = new RegisterStep1View autoRender: true, region: 'step1'
      @subview 'step1', step1
      step2 = new RegisterStep2View autoRender: true, region: 'step2'
      @subview 'step2', step2

      Backbone.Validation.bind(@, { model: @model })
      @modelBinder.bind(@model, @$el)

    register: (event) ->
      event.preventDefault()
      request = @model.save()
      request.done(=>
        @publishEvent '!createSession', @model
        Chaplin.utils.redirectTo name: 'root'
      )
      request.fail((request)=>
        # This iterates over the returned errors, and triggers
        # the validation callback for each.
        if request.responseJSON.errors
          _.each(request.responseJSON.errors, (error, field) =>
            Backbone.Validation.callbacks.invalid(@, field, "#{field} #{error[0]}", "name")
          )
        @displayFormError()
      )

    selectTab: (event) ->
      event.preventDefault()
      if @model.isValid(true)
        $(event.currentTarget).tab('show')
      else
        @displayFormError()

    displayFormError: ->
      @formErrorFlash = new FlashView(container: @$('.register-flash'), message: "Please fix the errors on the form.")
      @subview 'flash', @formErrorFlash

    hideFormError: ->
      if @formErrorFlash
        @formErrorFlash.dispose()
