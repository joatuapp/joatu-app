define [
  'views/base/view'
], (View) ->
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

    confirmAndRemove: ->
