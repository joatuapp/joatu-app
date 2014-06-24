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
      @delegate('click', '[data-dismiss=alert]', @dispose)
