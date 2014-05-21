define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class Collection extends Chaplin.Collection
    # Mixin a synchronization state machine.
    _.extend @prototype, Chaplin.SyncMachine
    initialize: (models, options) ->
      @on 'request', @beginSync
      @on 'sync', @finishSync
      @on 'error', @unsync
      super

    # Use the project base model per default, not Chaplin.Model
    model: Model

    parse: (response) ->
      return response.items

    sync: (method, model, options) ->
      $.support.cors = true;
      options = $.extend(options, {
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        complete: (jqxhr, status, error) =>
          if jqxhr.status == 401
            @subscribeEvent 'login', @fetch
            @publishEvent '!requireLogin'
      })
      if Chaplin.mediator.user
        options.headers["authorization"] = "Token token=" + Chaplin.mediator.user.get('authentication_token')
      super(method, model, options)
