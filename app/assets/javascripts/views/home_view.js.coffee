define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class HomeView extends View
    templateName: 'home'
    className: 'home text-center'
