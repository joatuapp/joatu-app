define [
  'views/base/view'
], (View) ->
  'use strict'

  class ModalHeader extends View
    noWrap: true
    templateName: 'modal_header'

    initialize: (options) ->
      super
      @content = options["content"]
