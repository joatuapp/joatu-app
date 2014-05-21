define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class Community extends Model
    urlRoot: ->
      Chaplin.mediator.api_base_url + "/communities"
