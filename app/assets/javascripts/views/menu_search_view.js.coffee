define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class MenuSearchView extends View
    templateName: 'menu_search'

    className: 'menu-search'
