define [
  'chaplin'
  'models/base/model'
  'models/tags'
], (Chaplin, Model, Tags) ->
  'use strict'

  class Offer extends Model
    initialize: (options) ->
      super
      window.offer = @
      @tagsCollection = new Tags
      @listenTo @, 'change:tags', @updateTagsCollection
      @updateTagsCollection()

    urlRoot: ->
      if @collection? && @isNew()
        @collection.url()
      else
        Chaplin.mediator.api_base_url + "/offers"
    
    defaults: {
      tags: []
    }

    updateTagsCollection: =>
      foo = "bar"
      @tagsCollection.set(@get('tags'), parse: true)
