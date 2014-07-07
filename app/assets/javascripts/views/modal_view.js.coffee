define [
  'views/base/view'
  'views/modal_header_view'
  'views/modal_footer_view'
], (View, ModalHeaderView, ModalFooterView) ->
  'use strict'

  class ModalView extends View
    templateName: 'modal'
    region: 'modal'
    className: 'modal'
    attributes: {role: "dialog", "aria-hidden": true}

    regions:
      'modal-header': '.modal-header'
      'modal-body': '.modal-body'
      'modal-footer': '.modal-footer'
    
    initialize: (options) ->
      # Can't over-ride region, should never need to!
      delete options["region"] if options["region"]?

      super
      if options["header"]
        if options["header"] instanceof View
          @headerView = options["header"]
        else if options["header"]
          @headerView = new ModalHeaderView (content: options["header"])
        @headerView.region = 'modal-header'
        @subview 'header', @headerView

      if options["footer"]
        if options["footer"] instanceof View
          @footerView = options["footer"]
        else if options["footer"]
          @footerView = new ModalFooterView (content: options["footer"])
        @footerView.region = 'modal-footer'
      @subview 'footer', @footerView

      @contentView = options["content"]
      @contentView.region = 'modal-body'
      @subview 'content', @contentView

      @delegate 'hidden.bs.modal', @dispose

    render: ->
      super

    attach: ->
      super
      @headerView.render() if @headerView
      @contentView.render()
      @footerView.render() if @footerView
      @$el.modal 'show'
