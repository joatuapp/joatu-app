define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class ProfileView extends View
    templateName: 'profile'
    className: 'profile'

    getTemplateData: () ->
      model: @model
