define [
  'chaplin'
  'views/base/view'
], (Chaplin, View) ->
  'use strict'

  class AboutView extends View
    templateName: 'about'
    className: 'about container-fluid'

    initialize: (options) ->
      super
