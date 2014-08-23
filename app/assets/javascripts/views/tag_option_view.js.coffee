define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class TagOptionView extends View
    templateName: 'tag_option'
    noWrap: true

    initialize: ->
      super
      foo = "bar"
