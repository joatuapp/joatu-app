define [
  'chaplin'
  'models/base/collection'
  'models/offer'
  'models/user'
], (Chaplin, Collection, Offer, User) ->
  'use strict'

  class Offers extends Collection
    initialize: (options) ->
      super
      if options
        if options["user"]?
          @user = options["user"]
        else if options["user_id"]?
          @user = new User id: options["user_id"]

    url: ->
      if @should_use_search_url
        Chaplin.mediator.api_base_url + "/search/offers"
      else if @user
        Chaplin.mediator.api_base_url + "/users/#{@user.id}/offers"
    model: Offer

    use_search_url: (val = true) ->
      @should_use_search_url = !!val
