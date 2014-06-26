define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class ProfileView extends View
    templateName: 'profile'
    className: 'profile'

    listen:
      'change model': 'render'
