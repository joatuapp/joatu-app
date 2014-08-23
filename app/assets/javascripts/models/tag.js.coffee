define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class Tag extends Model
    idAttribute: 'tag'
