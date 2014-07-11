define [
  'views/base/view'
], (View) ->
  'use strict'

  class ModalFooter extends View
    noWrap: true
    templateName: 'modal_footer'

    initialize: (options) ->
      super
      @content = options["content"]
