define [
  'chaplin'
  'models/base/model'
  'models/user_detail'
], (Chaplin, Model, UserDetail) ->
  'use strict'

  class User extends Model

    urlRoot: ->
      Chaplin.mediator.api_base_url + "/users"
    
    sign_in: (options) ->
      options ||= {}
      options.url = @urlRoot() + '/sign_in'
      @save(@attributes, options)

    parse: (response, options) ->
      if response['detail']
        @set('detail', new UserDetail(response['detail']))
        delete response['detail']

      response
