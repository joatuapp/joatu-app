define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class Offer extends Model
    urlRoot: ->
      Chaplin.mediator.api_base_url + "/offers"
    
