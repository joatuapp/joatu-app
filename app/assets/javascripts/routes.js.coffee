define ->
  'use strict'

  # The routes for the application. This module returns a function.
  # `match` is the match method of the Chaplin.Router.
  (match) ->

    match '', 'joatu#show', name: 'root'

    match 'login', 'session#showLoginView', name: 'login'
    match 'logout', 'session#logout', name: 'logout'
    match 'sign-up', 'session#logout', name: 'register'
