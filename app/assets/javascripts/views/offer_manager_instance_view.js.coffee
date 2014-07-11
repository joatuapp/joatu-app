define [
  'views/base/view'
  'views/offer_edit_form_view'
  'views/modal_view'
  'views/confirm_view'
  'views/tags_view'
], (View, OfferEditFormView, ModalView, ConfirmView, TagsView) ->
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
      bindings = {
        title: '.offer-title',
        summary: '.offer-summary'
      }

      @modelBinder.bind(@model, @$el, bindings)

      tags = new TagsView collection: @model.tagsCollection, container: @$el.find(".tag-container"), autoRender: true
      @subview 'tags', tags

    showEditModal: ->
      offerEditView = new OfferEditFormView model: @model
      editModal = new ModalView content: offerEditView, autoRender: true

    confirmAndRemove: ->
      @confirm.dispose() if @confirm?
      @confirm = new ConfirmView message: "Are you sure you want to stop offering #{@model.title}?", container: @$el
      @subview 'confirm', @confirm
      @listenTo @confirm, 'confirmed', @removeInstance
      @confirm.render()

    removeInstance: ->
      @model.destroy()
