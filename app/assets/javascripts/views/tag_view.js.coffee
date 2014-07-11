define [
  'views/base/view'
], (View) ->
  'use strict'

  class TagView extends View
    templateName: 'tag'
    tagName: 'li'

    render: ->
      super
      bindings = {
        tag: '.tag'
      }
      @modelBinder.bind(@model, @$el, bindings)
