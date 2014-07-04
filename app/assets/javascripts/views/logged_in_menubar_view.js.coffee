define [
  'chaplin'
  'views/base/view'
], (Chaplin, View, template) ->
  'use strict'

  class LoggedInMenubarView extends View
    templateName: 'logged_in_menubar'
    className: 'collapse navbar-collapse'
    id: 'top-navbar'

    render: ->
      super

      fullname_binding = {
        selector: '.current-user-fullname',
        converter: Chaplin.mediator.user.full_name
      }
      bindings = {
        given_name: fullname_binding,
        surname: fullname_binding,
        profile_image_url_tiny: {selector: '.current-user-image', elAttribute:'src'}
        id: {
          selector: '.my-profile-link', 
          converter: @generateProfileLink
          elAttribute:'href'
        }
      }
      @modelBinder.bind(Chaplin.mediator.user, @$el, bindings)

    generateProfileLink: (direction, value, model) =>
      if value?
        Chaplin.utils.reverse('profile', id: value)
      else
        ''
