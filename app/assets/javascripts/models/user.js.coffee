define [
  'chaplin'
  'models/base/model'
  'models/tags'
], (Chaplin, Model, Tags) ->
  'use strict'

  class User extends Model

    validation:
      username:
        required: true
      email:
        pattern: 'email',
        required: true
      email_confirmation:
        fn: 'emailConfirmed'
      password: required: false

    defaults: {
      accepted_currencies: []
    }

    initialize: (options) ->
      super
      @acceptedCurrenciesCollection = new Tags
      @listenTo @, "change:accepted_currencies", @updateAcceptedCurrenciesCollection
      @updateAcceptedCurrenciesCollection()

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

      name = $.trim(name)

      if name.length == 0
        if @get('username')?
          name = @get('username')
        else
          name = "unknown"

      name

    emailConfirmed: (value, attr, computed) ->
      if computed.email? && computed.email_confirmation?
        unless computed.email == computed.email_confirmation
          return "Does not match email"

    updateAcceptedCurrenciesCollection: ->
      @acceptedCurrenciesCollection.set(@get('accepted_currencies'), parse: true)
