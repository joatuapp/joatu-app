define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class User extends Model
    validation:
      username:
        required: true
      email:
        required: true,
        pattern: 'email'

    urlRoot: ->
      Chaplin.mediator.api_base_url + "/users"
    
    sign_in: (options) ->
      options ||= {}
      options.url = @urlRoot() + '/sign_in'
      @save(@attributes, options)

    full_name: =>
      name = ''
      if @get('given_name')?
        name += @get('given_name')

      if @get('surname')?
        name += ' ' + @get('surname')

      if name.length == 0
        name = "unknown"

      $.trim(name)
