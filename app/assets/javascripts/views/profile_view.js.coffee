define [
  'views/base/view'
  'views/profile_offers_view'
  'views/tags_view'
  'models/offers'
], (View, ProfileOffersView, TagsView, Offers) ->
  'use strict'

  class ProfileView extends View
    templateName: 'profile'
    className: 'profile container-fluid'

    regions:
      offers: '#offers-container'
      currencies: '#currencies-container'

    initialize: ->
      super
      @offers = new Offers user: @model
      @offers.fetch()

    render: ->
      super

      offersView = new ProfileOffersView autoRender: true, region: 'offers', collection: @offers
      @subview 'offers', offersView

      acceptedCurrenciesView = new TagsView collection: @model.acceptedCurrenciesCollection, region: 'currencies',  autoRender: true
      @subview 'accepted_currencies', acceptedCurrenciesView
      
      fullname_binding = {
        selector: '.profile-fullname',
        converter: this.model.full_name
      }
      bindings = {
        given_name: fullname_binding,
        surname: fullname_binding,
        profile_image_url_thumbnail: {selector: '.profile-image', elAttribute:'src'}
        about_me: '.about-me'
      }
      @modelBinder.bind(@model, @$el, bindings)
