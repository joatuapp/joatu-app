define ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is the match method of the Chaplin.Router.
  (match) ->

    match '', 'home#show', name: 'root'
    match 'register', 'register#show', name: 'register'
    match 'logout', 'session#logout', name: 'logout'
    match 'profile/:id', 'user#show'
    match 'profile/:id/edit', 'user#edit'
    match 'profile/:id/edit/offers', 'offer#edit'

