define [
  'chaplin'
  'views/base/view'
], (Chaplin, View) ->
  'use strict'

  class HomeView extends View
    templateName: 'home'
    className: 'home text-center'

    initialize: (options) ->
      super
      @delegate 'submit', 'form', @search

    search: (event) =>
      event.preventDefault()
      Chaplin.utils.redirectTo "search#offers", search: @$el.find('input[type=search]').val()
