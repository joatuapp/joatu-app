define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  class Model extends Chaplin.Model
  # Mixin a synchronization state machine.
    _.extend @prototype, Chaplin.SyncMachine
    initialize: ->
      super
      @on 'request', @beginSync
      @on 'sync', @finishSync
      @on 'error', @unsync

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
