define [
  'controllers/base/controller'
  'models/offers'
  'views/offer_manager_view'
  'controllers/session_controller'
], (Controller, Offers, OffersManagerView, SessionController) ->
  'use strict'

  class OfferController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    title: 'Edit offers'

    edit: (params) ->
      @collection = new Offers user_id: params["user_id"]
      @collection.fetch()
      @view = new OffersManagerView collection: @collection, region: 'main', autoRender: true
