define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class SiteView extends View
    el: 'body'
    regions:
      navbar: '#navbar-top'
      main: '#main-container'
      footer: '#footer'
      modal: "#modal-container"
    templateName: 'site'
