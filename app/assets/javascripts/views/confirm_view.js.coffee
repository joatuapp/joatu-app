define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class ConfirmView extends View
    noWrap: true
    templateName: 'confirm'


    initialize: (options) ->
      super
      @message = options["message"]
      @delegate('click', '[data-dismiss=alert]', @dispose)
      @delegate('click', '.confirm-yes', @confirmYes)
      @delegate('click', '.confirm-no', @confirmNo)

    getTemplateData: ->
      {message: @message}

    confirmYes: =>
      @trigger 'confirmed', @
      @dispose()

    confirmNo: =>
      @trigger 'canceled', @
      @dispose()

