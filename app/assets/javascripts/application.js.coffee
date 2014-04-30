# Require HAML Coffee templates
#= require hamlcoffee
#= require_tree ./templates

# Bootstrap the application
require [
  'jquery'
  'bootstrap'
  'joatu_application'
  'routes'
  # Require base controllers manually so they are
  # precompiled by the Rails Asset Pipeline
  'controllers/joatu_controller'
], ($, _bootstrap, JoatuApplication, routes) ->
  'use strict'

  new JoatuApplication
    # Set your application name here so the document title is set to
    # “Controller title – Site title” (see Chaplin.Layout#adjustTitle)
    title: 'JoatU'
    # The routes for this app
    routes: routes
