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
        id: [{
          selector: '.my-profile-link', 
          converter: @generateProfileLink
          elAttribute: 'href'
        },{
          selector: '.edit-profile-link', 
          converter: @generateEditProfileLink
          elAttribute: 'href'
        },{
          selector: '.logout-link', 
          converter: @generateLogoutLink
          elAttribute: 'href'
        },{
          selector: '.manage-offers-link',
          converter: @generateManageOffersLink
          elAttribute: 'href'
        }]
      }
      @modelBinder.bind(Chaplin.mediator.user, @$el, bindings)

    generateProfileLink: (direction, value, model) =>
      if value?
        Chaplin.utils.reverse('profile', id: value)
      else
        ''

    generateEditProfileLink: (direction, value, model) =>
      if value?
        Chaplin.utils.reverse('edit_profile', id: value)
      else
        ''

    generateManageOffersLink: (direction, value, model) =>
      if value?
        Chaplin.utils.reverse('manage_offers', user_id: value)
      else
        ''

    generateLogoutLink: (direction, value, model) =>
      if value?
        Chaplin.utils.reverse('logout', id: value)
      else
        ''
