define [
  'chaplin'
  'models/base/collection'
  'models/offer'
], (Chaplin, Collection, Offer) ->
  'use strict'

  class Offers extends Collection
    initialize: (options) ->
      super
      @user = options["user"] if options["user"]?

    url: ->
      if @user
        Chaplin.mediator.api_base_url + "/users/#{@user.id}/offers"
    model: Offer
