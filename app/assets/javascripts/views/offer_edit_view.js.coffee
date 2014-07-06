define [
  'views/base/collection_view'
  'models/flash'
  'views/flash_view'
], (View, Flash, FlashView) ->
  'use strict'

  class OffersEditView extends CollectionView
    templateName: 'offers_edit'
    className: 'offers-edit container-fluid'

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
      model = new Flash(message: "Please fix the errors on the form.")
      flash = new FlashView(container: @$('.register-flash'), model: model)
      @subview 'flash', flash

