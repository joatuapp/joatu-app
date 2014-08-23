define [
  'controllers/base/controller'
  'models/search_collection'
  'views/offers_search_view'
  'controllers/session_controller'
], (Controller, SearchCollection, OffersSearchView, SessionController) ->
  'use strict'

  class SearchController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    title: 'Search'

    offers: (params) ->
      @collection = new SearchCollection(type: "offers")
      @collection.fetch(data: {search: params["search"]})
      @view = new OffersSearchView collection: @collection, region: 'main', autoRender: true
