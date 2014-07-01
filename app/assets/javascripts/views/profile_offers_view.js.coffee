define [
  'views/base/collection_view'
  'views/profile_offer_view'
], (CollectionView, ProfileOfferView) ->
  'use strict'

  class ProfileOffersView extends CollectionView
    templateName: 'profile_offers'
    itemView: ProfileOfferView
    listSelector: '.offers-list'
    fallbackSelector: '.no-offers'
    loadingSelector: '.loading'
