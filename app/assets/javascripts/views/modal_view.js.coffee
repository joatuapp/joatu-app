define [
  'chaplin'
  'views/base/view'
  'views/modal_header_view'
  'views/modal_footer_view'
], (Chaplin, View, ModalHeaderView, ModalFooterView) ->
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
      # This code uses the mediator to make sure theres
      # only one instance of this view in existance at
      # any given time. That means other parts of the code
      # don't have to worry about opening multiple modal
      # boxes at the same time.
      if Chaplin.mediator.modal?
        Chaplin.mediator.modal.dispose()

      Chaplin.mediator.modal = @

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

    attach: ->
      super
      @headerView.render() if @headerView
      @contentView.render()
      @footerView.render() if @footerView
      @$el.modal 'show'

    dispose: =>
      return if @disposed
      @$el.modal 'hide'
      super
