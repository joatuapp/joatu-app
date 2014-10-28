# Require HAML Coffee templates
#= require hamlcoffee
#= require i18n/translations
#= require_tree ./templates

# Bootstrap the application
require [
  'jquery'
  'bootstrap'
  'joatu_application'
  'routes'
  'i18n'
  # Require base controllers manually so they are
  # precompiled by the Rails Asset Pipeline
  'controllers/home_controller'
  'controllers/offer_controller'
  'controllers/register_controller'
  'controllers/search_controller'
  'controllers/session_controller'
  'controllers/user_controller'
  'controllers/about_controller'
], ($, _bootstrap, JoatuApplication, routes, I18n) ->
  'use strict'

  new JoatuApplication
    # Set your application name here so the document title is set to
    # “Controller title – Site title” (see Chaplin.Layout#adjustTitle)
    title: I18n.t('joatu_title')
    
    # The routes for this app
    routes: routes
