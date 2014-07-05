define [
  'views/base/collection_view'
  'views/community_option'
], (CollectionView, CommunityOption, template) ->
  'use strict'

  class CommunitySelectView extends CollectionView
    autoRender: true
    templateName: 'community_select'
    itemView: CommunityOption
    listSelector: '[name=community_id]'
    fallbackSelector: '#no-communities'

    render: ->
      super
      @listenTo @collection, "add", @collectionUpdateHandler
      @listenTo @collection, "remove", @collectionUpdateHandler
      @setupAutocomplete()

    setupAutocomplete: ->
      input = @$el.find('#autocomplete_location').get(0)
      options = {}
      @autoComplete = new google.maps.places.Autocomplete(input, options)
      google.maps.event.addListener(@autoComplete, 'place_changed', @placeSelected)

    placeSelected: =>
      @populateHiddenFieldsFromPlace()
      @displayCommunitySelect()

    displayCommunitySelect: ->
      place = @autoComplete.getPlace()
      @collection.fetch({data: {latitude: place.geometry.location.k, longitude: place.geometry.location.B}})

    collectionUpdateHandler: ->
      if @collection.length > 0
        $('#community_select').removeClass('hidden')
      else
        $('#community_select').addClass('hidden')

    populateHiddenFieldsFromPlace: ->
      place = @autoComplete.getPlace()
      $('#user_neighbourhood').val('')
      $('#user_postal_code').val('')
      $('#user_city').val('')
      $('#user_province').val('')
      $('#user_country').val('')
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

      $('#user_latitude').val(place.geometry.location.k)
      $('#user_longitude').val(place.geometry.location.B)
