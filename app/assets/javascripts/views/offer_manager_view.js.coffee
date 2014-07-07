define [
  'views/base/collection_view'
  'views/offer_manager_instance_view'
], (CollectionView, OfferManagerInstanceView) ->
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

      window.col = @collection
