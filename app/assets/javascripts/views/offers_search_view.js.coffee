define [
  'views/base/collection_view'
  'views/profile_offer_view'
], (CollectionView, ProfileOfferView) ->
  'use strict'

  class OffersSearchView extends CollectionView
    autoRender: true
    templateName: 'offer_search'
    itemView: ProfileOfferView
    listSelector: "#offers-collection"
    loadingSelector: "#offers-loading"
    fallbackSelector: "#offers-fallback"
    className: 'offer-search container-fluid'
