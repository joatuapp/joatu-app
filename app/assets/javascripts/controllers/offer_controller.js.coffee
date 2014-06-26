define [
  'controllers/base/controller'
  'models/offer'
  'views/offer_view'
  'controllers/session_controller'
], (Controller, Offer, OfferView, SessionController) ->
  'use strict'

  class OfferController extends Controller

    beforeAction: ->
      super
      @reuse 'session', SessionController

    title: 'Edit offers'

    show: (params) ->
      @model = new Offer id: params["id"]
      @view = new OfferView model: @model, region: 'main', autoRender: true
