define ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is the match method of the Chaplin.Router.
  (match) ->

    match '', 'home#show', name: 'root'
    match 'register', 'register#step1', name: 'register'
    match 'register/step1', 'register#step1'

