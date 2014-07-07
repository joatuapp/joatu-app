define [
  'views/base/view'
  'views/flash_view'
], (View, FlashView) ->
  'use strict'

  class OfferEditFormView extends View
    templateName: 'offer_edit_form'

    initialize: (options) ->
      super
      @delegate('submit', 'form', @save)

    render: (options) ->
      super
      Backbone.Validation.bind(@)
      bindings = Backbone.ModelBinder.createDefaultBindings(@$el, 'name');
      @modelBinder.bind(@model, @$el, bindings)

    save: (event) ->
      event.preventDefault()
      request = @model.save()
      request.fail(=>
        @displayFormError()
        # TODO: Handle server side failure.
        # should only need to cover connection issues
        # as data should (normally) be 
        # validated client side.
      )

    displayFormError: ->
      flash = new FlashView(container: @$('.register-flash'), message: "Please fix the errors on the form.")
      @subview 'flash', flash

