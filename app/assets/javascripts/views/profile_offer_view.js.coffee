define [
  'chaplin'
  'views/base/view'
  'views/tags_view'
], (Chaplin, View, TagsView) ->
  'use strict'

  class ProfileOfferView extends View
    templateName: 'profile_offer'
    className: 'offer col-md-6'

    render: ->
      super
      bindings = {
        title: '.offer-title',
        description: '.offer-description'
      }

      @modelBinder.bind(@model, @$el, bindings)

      tags = new TagsView collection: @model.tagsCollection, container: @$el.find(".tag-container"), autoRender: true
      @subview 'tags', tags

      availabilities = new TagsView collection: @model.availabilitiesCollection, container: @$el.find(".availability-container"), autoRender: true
      @subview 'availabilities', availabilities

    categorySearchUrl: (direction, value, mode) =>
      if value?
        Chaplin.utils.reverse('offer_category_search', category_id: value)
      else
        ''
