define [
  'views/base/view'
  'views/profile_offers_view'
  'models/offers'
], (View, ProfileOffersView, Offers) ->
  'use strict'

  class ProfileView extends View
    templateName: 'profile'
    className: 'profile'

    regions:
      offers: '#offers-container'

    initialize: ->
      super
      @offers = new Offers user: @model

    render: ->
      super
      fullname_binding = {
        selector: '.profile-fullname',
        converter: this.model.full_name
      }
      bindings = {
        given_name: fullname_binding,
        surname: fullname_binding
      }
      @modelBinder.bind(@model, @$el, bindings)

      offersView = new ProfileOffersView autoRender: true, region: 'offers', collection: @offers
      @subview 'offers', offersView
      @offers.fetch()

    dispose: ->
      @modelBinder.unbind()
      super
