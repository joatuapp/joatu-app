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

    initialize: (options) ->
      super
      @delegate 'submit', 'form', @search

    render: ->
      super
      tagsInputOptions = $.extend({}, @options, {
        # Confirm on enter, tab, or comma (respectively)
        confirmKeys: [13, 9, 188] 
      })

      @tagsInputs = @$el.find("select[multiple][data-role=tagsinput]").tagsinput(tagsInputOptions)

    search: (event) =>
      event.preventDefault()

      searchTerms = @tagsInputs[0].itemsArray
      @collection.fetch(data: {search: searchTerms})
