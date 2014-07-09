define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class Offer extends Model
    urlRoot: ->
      if @collection? && @isNew()
        @collection.url()
      else
        Chaplin.mediator.api_base_url + "/offers"
    
    defaults: {
      tags: []
    }
