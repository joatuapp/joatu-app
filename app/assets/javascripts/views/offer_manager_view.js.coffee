define [
  'views/base/collection_view'
  'views/offer_manager_instance_view'
  'views/offer_edit_form_view'
  'views/modal_view'
  'models/offer'
], (CollectionView, OfferManagerInstanceView, OfferEditFormView, ModalView, Offer) ->
  'use strict'

  class OfferManagerView extends CollectionView
    autoRender: true
    templateName: 'offer_manager'
    itemView: OfferManagerInstanceView
    listSelector: "#offers-collection"
    loadingSelector: "#offers-loading"
    fallbackSelector: "#offers-fallback"
    className: 'offer-manager container-fluid'

    initialize: (options) ->
      super
      @delegate 'click', '.add-offer', @addOffer

    addOffer: (event) =>
      model = new Offer
      offerEditView = new OfferEditFormView model: model, collection: @collection
      editModal = new ModalView content: offerEditView, autoRender: true
      
