define [
  'views/base/view'
  'views/community_select_view'
  'models/communities'
], (View, CommunitySelectView, Communities, template) ->
  'use strict'

  class RegisterStep2View extends View
    templateName: 'register_step2'
    className: 'step2-content'

    regions:
      communitySelect: "#community_select_container"

    attach: ->
      super
      @setupAutocomplete()

    setupAutocomplete: ->
      input = $('#autocomplete_location').get(0)
      options = {}
      @autoComplete = new google.maps.places.Autocomplete(input, options)
      google.maps.event.addListener(@autoComplete, 'place_changed', @placeSelected)

    placeSelected: =>
      @populateHiddenFieldsFromPlace()
      @displayCommunitySelect()

    displayCommunitySelect: ->
      unless @communitySelect
        @communities = new Communities
        @communitySelect = new CommunitySelectView region: 'communitySelect', collection: @communities
        @subview 'communitySelect', @communitySelect

      place = @autoComplete.getPlace()
      @communities.fetch({data: {latitude: place.geometry.location.k, longitude: place.geometry.location.A}})

    populateHiddenFieldsFromPlace: ->
      place = @autoComplete.getPlace()
      for index, component of place.address_components
        if $.inArray('neighborhood', component.types) >= 0
          $('#user_neighbourhood').val(component.long_name)
        if $.inArray('postal_code', component.types) >= 0
          $('#user_postal_code').val(component.long_name)
        if $.inArray('locality', component.types) >= 0
          $('#user_city').val(component.long_name)
        if $.inArray('administrative_area_level_1', component.types) >= 0
          $('#user_province').val(component.long_name)
        if $.inArray('country', component.types) >= 0
          $('#user_country').val(component.long_name)

      $('#user_location_latitude').val(place.geometry.location.k)
      $('#user_location_longitude').val(place.geometry.location.A)
