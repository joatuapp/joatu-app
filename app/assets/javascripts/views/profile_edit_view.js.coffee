define [
  'views/base/view'
  'views/community_select_view'
  'models/communities'
  'views/flash_view'
], (View, CommunitySelectView, Communities, FlashView) ->
  'use strict'

  class ProfileEditView extends View
    templateName: 'profile_edit'
    className: 'profile-edit container-fluid'

    regions:
      communitySelect: "#community_select_container"

    initialize: (options) ->
      super
      @delegate 'click', '#profile-edit-tabs a', @switchTabs
      @delegate('submit', 'form', @save)

    render: (options) ->
      super
      @communitySelect = new CommunitySelectView region: 'communitySelect', collection: new Communities
      @subview 'communitySelect', @communitySelect

      Backbone.Validation.bind(@)
      bindings = Backbone.ModelBinder.createDefaultBindings(@$el, 'name');
      bindings["community_name"] = "#current-community"
      @modelBinder.bind(@model, @$el, bindings)

    switchTabs: (event) ->
      event.preventDefault()
      $(event.currentTarget).tab('show')

    save: (event) ->
      event.preventDefault()
      request = @model.save()
      request.fail(=>
        @displayFormError()
        # TODO: Handle server side failure.
        # should only need to cover connection issues
        # as data should (normally) be 
        # validated client side.
      )

    displayFormError: ->
      flash = new FlashView(container: @$('.register-flash'), message: "Please fix the errors on the form.")
      @subview 'flash', flash

