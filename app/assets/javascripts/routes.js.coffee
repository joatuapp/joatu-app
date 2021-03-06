define ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is the match method of the Chaplin.Router.
  (match) ->

    match '', 'home#show', name: 'root'
    match 'about', 'about#show', name: 'about'
    match 'register/confirm/:confirmation_token', 'register#confirm', name: 'register_confirm'
    match 'register', 'register#show', name: 'register'
    match 'logout', 'session#logout', name: 'logout'
    match 'profile/:id', 'user#show', name: 'profile'
    match 'profile/:id/edit', 'user#edit', name: 'edit_profile'
    match 'profile/:user_id/edit/offers', 'offer#edit', name: 'manage_offers'

    match 'search/offers/:search', 'search#offers'
    match 'search/offers', 'search#offers', name: 'offer_search'
