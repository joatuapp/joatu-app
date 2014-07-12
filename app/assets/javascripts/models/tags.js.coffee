define [
  'chaplin'
  'models/base/collection'
  'models/tag'
], (Chaplin, Collection, Tag) ->
  'use strict'

  class Tags extends Collection
    model: Tag
    parse: (response, options) ->
      out = []
      _.each(response, (tag) ->
        out.push {tag: tag}
      )
      out
