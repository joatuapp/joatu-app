define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class User extends Model

    urlRoot: ->
      Chaplin.mediator.api_base_url + "/users"
    
    sign_in: (options) ->
      options ||= {}
      options.url = @urlRoot() + '/sign_in'
      @save(@attributes, options)
