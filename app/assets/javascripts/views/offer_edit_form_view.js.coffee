define [
  'views/base/view'
  'views/flash_view'
], (View, FlashView) ->
  'use strict'

  class OfferEditFormView extends View
    templateName: 'offer_edit_form'
    className: 'clearfix'

    initialize: (options) ->
      super
      @delegate('submit', 'form', @save)
      @delegate('click', '.cancel', @cancel)

    render: (options) ->
      super

      # This needs to go before the model binding, so that
      # the model can bind to the elements it creates.
      tagsInputOptions = {
        # Confirm on enter, space, tab, or comma (respectively)
        confirmKeys: [13, 32, 9, 188] 
      }
      @tagsInputs = @$el.find("input[data-role=tagsinput], select[multiple][data-role=tagsinput]").tagsinput(tagsInputOptions)

      Backbone.Validation.bind(@)
      bindings = Backbone.ModelBinder.createDefaultBindings(@$el, 'name');
      @modelBinder.bind(@model, @$el, bindings)


    dispose: ->
      if @tagsInputs
        _.each @tagsInputs, (tagInput) ->
          tagInput.destroy()
      super

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

