define [
  'chaplin'
  'models/base/collection'
  'models/community'
], (Chaplin, Collection, Community) ->
  'use strict'

  class Communities extends Collection
    url: ->
      Chaplin.mediator.api_base_url + "/communities"
    model: Community
