define [
  'chaplin'
  'backbone-modelbinder'
  'lib/view_helper' # Just load the view helpers, no return value
], (Chaplin, BackboneModelBinder) ->
  'use strict'

  class View extends Chaplin.View

    initialize: (options) ->
      super
      @modelBinder = new BackboneModelBinder

    getTemplateFunction: ->
      #console.log 'View#getTemplateFunction', @templateName, JST[@templateName]
      templateFunction = JST[@templateName]
      if typeof @templateName is 'string' and typeof templateFunction isnt 'function'
        throw new Error "View template #{@templateName} not found"

      templateFunction
