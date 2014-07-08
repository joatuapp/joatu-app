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
      @delegate('click', '.cancel', @cancel)

    render: (options) ->
      super
      Backbone.Validation.bind(@)
      bindings = Backbone.ModelBinder.createDefaultBindings(@$el, 'name');
      @modelBinder.bind(@model, @$el, bindings)

    save: (event) ->
      @model.collection = @collection if @collection?
      event.preventDefault()
      request = @model.save()
      request.done(=>
        if @collection
          @collection.add @model
        @closeIfModal()
      )
      request.fail(=>
        @displayFormError()
        # TODO: Handle server side failure.
        # should only need to cover connection issues
        # as data should (normally) be 
        # validated client side.
      )

    cancel: (event) =>
      event.preventDefault()
      # Re-sets the model to it's previous (unmodified)
      # attributes, or destroys it if it's new.
      if @model.isNew()
        @model.destroy()
      else
        @model.set(@model.previousAttributes())
      @closeIfModal()

    displayFormError: ->
      flash = new FlashView(container: @$('.register-flash'), message: "Please fix the errors on the form.")
      @subview 'flash', flash

