define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class UserDetail extends Model

    urlRoot: ->
      Chaplin.mediator.api_base_url + "/user_details"
    
    full_name: ->
      name = ''
      if @get('given_name')?
        name += @get('given_name')

      if @get('surname')?
        name += ' ' + @get('surname')

      if name.length == 0
        name = "unknown"

      $.trim(name)
