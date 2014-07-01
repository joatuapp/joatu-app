define [
  'views/base/collection_view'
  'views/profile_offer_view'
], (CollectionView, ProfileOfferView) ->
  'use strict'

  class ProfileOffersView extends CollectionView
    itemView: ProfileOfferView
