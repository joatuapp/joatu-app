define [
  'controllers/base/controller'
  'models/offers'
  'views/offers_search_view'
  'controllers/session_controller'
], (Controller, Offers, OffersSearchView, SessionController) ->
  'use strict'

  class SearchController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    title: 'Search'

    offers: (params) ->
      @collection = new Offers
      @collection.use_search_url()
      @collection.fetch(data: params)
      @view = new OffersSearchView collection: @collection, region: 'main', autoRender: true
