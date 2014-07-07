define [
  'views/base/view'
  'views/offer_edit_form_view'
  'views/modal_view'
  'views/confirm_view'
], (View, OfferEditFormView, ModalView, ConfirmView) ->
  'use strict'

  class OfferManagerInstanceView extends View
    autoRender: true
    templateName: 'offer_manager_instance'
    className: 'offer-manager-instance'

    initialize: (options) ->
      super
      @delegate 'click', '.edit-button', @showEditModal
      @delegate 'click', '.remove-button', @confirmAndRemove


    render: ->
      super
      @modelBinder.bind(@model, @$el)

    showEditModal: ->
      offerEditView = new OfferEditFormView model: @model
      editModal = new ModalView content: offerEditView, autoRender: true
      editModal.render()

    confirmAndRemove: ->
      @confirm.dispose() if @confirm?
      @confirm = new ConfirmView message: "Are you sure you want to stop offering #{@model.title}?", container: @$el
      @subview 'confirm', @confirm
      @listenTo @confirm, 'confirmed', @removeInstance
      @confirm.render()

    removeInstance: ->
      @model.destroy()
