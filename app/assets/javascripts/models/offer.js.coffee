define [
  'chaplin'
  'models/base/model'
  'models/tags'
], (Chaplin, Model, Tags) ->
  'use strict'

  class Offer extends Model
    initialize: (options) ->
      super
      @tagsCollection = new Tags
      @updateTagsCollection()
      @listenTo @, "change:tags", @updateTagsCollection

      @availabilitiesCollection = new Tags
      @updateAvailabilitiesCollection()
      @listenTo @, "change:availabilities", @updateAvailabilitiesCollection

    urlRoot: ->
      if @collection? && @isNew()
        @collection.url()
      else
        Chaplin.mediator.api_base_url + "/offers"
    
    defaults: {
      tags: []
    }

    updateTagsCollection: =>
      @tagsCollection.set(@get('tags'), parse: true)

    updateAvailabilitiesCollection: =>
      @availabilitiesCollection.set(@get('availabilities'), parse: true)
