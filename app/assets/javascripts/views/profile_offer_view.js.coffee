define [
  'chaplin'
  'views/base/view'
], (Chaplin, View) ->
  'use strict'

  class ProfileOfferView extends View
    templateName: 'profile_offer'
    className: 'offer col-md-6'

    render: ->
      super
      bindings = {
        title: '.offer-title',
        description: '.offer-description',
        category_name: '.offer-category'
        category_id: {
          selector: '.offer-category',
          elAttribute: 'href',
          converter: @categorySearchUrl
        }
      }

      @modelBinder.bind(@model, @$el, bindings)

    categorySearchUrl: (direction, value, mode) =>
      if value?
        Chaplin.utils.reverse('offer_category_search', category_id: value)
      else
        ''
