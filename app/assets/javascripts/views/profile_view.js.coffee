define [
  'views/base/view'
  'views/profile_offers_view'
  'models/offers'
], (View, ProfileOffersView, Offers) ->
  'use strict'

  class ProfileView extends View
    templateName: 'profile'
    className: 'profile container-fluid'

    regions:
      offers: '#offers-container'

    initialize: ->
      super
      @offers = new Offers user: @model
      @offers.fetch()

    render: ->
      super

      offersView = new ProfileOffersView autoRender: true, region: 'offers', collection: @offers
      @subview 'offers', offersView
      
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
