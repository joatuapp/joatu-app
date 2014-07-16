define [
  'chaplin'
  'models/base/collection'
  'models/offer'
  'models/user'
], (Chaplin, Collection, Offer, User) ->
  'use strict'

  class SearchCollection extends Collection
    initialize: (options) ->
      @type = options["type"] || "offers"
      delete options["type"]
      super

    url: ->
      Chaplin.mediator.api_base_url + "/search/" + @type

    model: (attrs, options) =>
      if @type == "offers"
        new Offer(attrs, options)
