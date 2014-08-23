define [
  'chaplin'
  'backbone-modelbinder'
  'bootstrap-tagsinput'
  'lib/view_helper' # Just load the view helpers, no return value
  'backbone-validation'
], (Chaplin) ->
  'use strict'

  class View extends Chaplin.View

    initialize: (options) ->
      super
      Backbone.ModelBinder.SetOptions({modelSetOptions: {validate: true}})
      @modelBinder = new Backbone.ModelBinder

      # Configuring valid & invalid handlers (default)
      # for Backbone.Validate:
      _.extend(Backbone.Validation.callbacks, {
        valid: (view, attr, selector) ->
          control = view.$('[' + selector + '=' + attr + ']')
          group = control.parents('.form-group')
          group.removeClass('has-error')

          if control.data('error-style') == 'tooltip'
            # CAUTION: calling tooltip('hide') on an uninitialized tooltip
            # causes bootstraps tooltips to crash somehow...
            control.tooltip 'hide' if control.data('tooltip')
          else if control.data('error-style') == 'inline'
            group.find('.help-inline.error-message').remove()
          else
            group.find('.help-block.error-message').remove()
        invalid: (view, attr, error, selector) ->
          control = view.$('[' + selector + '=' + attr + ']')
          group = control.parents('.form-group')
          group.addClass('has-error')

          if control.data('error-style') == 'tooltip'
            position = control.data('tooltip-position') || 'right'
            control.tooltip
              placement: position
              trigger: 'manual'
              title: error
            control.tooltip 'show'
          else if control.data('error-style') == 'inline'
            if group.find('.help-inline').length == 0
              group.find('.form-control').after('<span class=\'help-inline error-message\'></span>')
            target = group.find('.help-inline')
            target.text(error)
          else
            if group.find('.help-block').length == 0
              group.find('.form-control').after('<p class=\'help-block error-message\'></p>')
            target = group.find('.help-block')
            target.text(error)
      })

    getTemplateFunction: ->
      #console.log 'View#getTemplateFunction', @templateName, JST[@templateName]
      templateFunction = JST[@templateName]
      if typeof @templateName is 'string' and typeof templateFunction isnt 'function'
        throw new Error "View template #{@templateName} not found"

      templateFunction

    closeIfModal: ->
      if Chaplin.mediator.modal.contentView == @
        Chaplin.mediator.modal.dispose()

    dispose: ->
      Backbone.Validation.unbind(@)
      @modelBinder.unbind()
      super
