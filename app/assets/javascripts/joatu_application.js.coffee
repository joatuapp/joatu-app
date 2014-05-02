define ['chaplin'], (Chaplin) ->
  'use strict'

  # The application object
  # Choose a meaningful name for your application
  class JoatuApplication extends Chaplin.Application
    # Create aditional mediator properties
    # ------------------------------------
    initMediator: ->
      # Create a user property
      Chaplin.mediator.user = null

      # Create a base url property
      # Chaplin.mediator.base_url = configs().base_url
      Chaplin.mediator.base_url = "http://local.joatu.com"

      # Seal the mediator
      Chaplin.mediator.seal()
