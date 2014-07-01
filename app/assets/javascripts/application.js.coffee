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
  # ALEX NOTE: I'm not actually sure this is necessary
  # so skipping for now.
], ($, _bootstrap, JoatuApplication, routes, I18n) ->
  'use strict'

  new JoatuApplication
    # Set your application name here so the document title is set to
    # “Controller title – Site title” (see Chaplin.Layout#adjustTitle)
    title: I18n.t('joatu_title')
    
    # The routes for this app
    routes: routes
