define [
  'chaplin'
  'models/base/collection'
], (Chaplin, Collection) ->
  'use strict'

  class Tags extends Collection
    parse: (response, options) ->
      out = []
      _.each(response, (tag) ->
        out.push {tag: tag}
      )
      out
