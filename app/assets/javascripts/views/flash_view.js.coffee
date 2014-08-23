define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class FlashView extends View
    autoRender: true
    noWrap: true
    templateName: 'flash'


    initialize: (options) ->
      super
      @message = options["message"]
      @type = options["type"]
      @delegate('click', '[data-dismiss=alert]', @dispose)

    getTemplateData: ->
      {message: @message, type: @type}
