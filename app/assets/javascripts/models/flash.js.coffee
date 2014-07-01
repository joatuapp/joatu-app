define [
  'chaplin'
  'models/base/model'
], (Chaplin, Model) ->
  'use strict'

  class Flash extends Model
    defaults:
      message: "Something went wrong"
      type: "danger"
