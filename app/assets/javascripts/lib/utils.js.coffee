define [
  'underscore'
  'chaplin'
], (_, Chaplin) ->
  'use strict'

  # Application-specific utilities
  # ------------------------------

  # Delegate to Chaplin’s utils module
  utils = Chaplin.utils.beget Chaplin.utils

  # Add additional application-specific properties and methods

  _(utils).extend

    # camel-case-helper > camelCaseHelper
    camelize: do ->
      regexp = /[-_]([a-z])/g
      camelizer = (match, c) ->
        c.toUpperCase()
      (string) ->
        string.replace regexp, camelizer

    # dashHelper -> dash-helper
    dasherize: (string) ->
      string.replace /[A-Z]/g, (char, index) ->
        (if index isnt 0 then '-' else '') + char.toLowerCase()

    # Load additonal JavaScripts
    # --------------------------

    # We don’t use jQuery here because jQuery does not attach an error
    # handler to the script. In jQuery, a proper error handler only works
    # for same-origin scripts which can be loaded via XHR.
    loadLib: (url, success, error, timeout = 7500) ->
      head = document.head or document.getElementsByTagName('head')[0] or
        document.documentElement
      script = document.createElement 'script'
      script.async = 'async'
      script.src = url

      onload = (_, aborted = false) ->
        return unless (aborted or
        not script.readyState or script.readyState is 'complete')

        clearTimeout timeoutHandle

        # Handle memory leak in IE
        script.onload = script.onreadystatechange = script.onerror = null
        # Remove the script elem and its reference
        head.removeChild(script) if head and script.parentNode
        script = undefined

        success() if success and not aborted

      script.onload = script.onreadystatechange = onload

      # This is what jQuery is missing
      script.onerror = ->
        onload null, true
        error() if error

      timeoutHandle = setTimeout script.onerror, timeout
      head.insertBefore script, head.firstChild
    
    # Persistent data storage
    # -----------------------

    # sessionStorage with session cookie fallback
    # sessionStorage(key) gets the value for 'key'
    # sessionStorage(key, value) set the value for 'key'
    sessionStorage: do ->
      if window.sessionStorage and sessionStorage.getItem and
      sessionStorage.setItem and sessionStorage.removeItem
        (key, value) ->
          if typeof value is 'undefined'
            value = sessionStorage.getItem(key)
            if value? and value.toString then value.toString() else value
          else
            sessionStorage.setItem(key, value)
            value
      else
        (key, value) ->
          if typeof value is 'undefined'
            utils.getCookie(key)
          else
            utils.setCookie(key, value)
            value

    # sessionStorageRemove(key) removes the storage entry for 'key'
    sessionStorageRemove: do ->
      if window.sessionStorage and sessionStorage.getItem and
      sessionStorage.setItem and sessionStorage.removeItem
        (key) -> sessionStorage.removeItem(key)
      else
        (key) -> utils.expireCookie(key)

    # Cookie fallback
    # ---------------

    # Get a cookie by its name
    getCookie: (key) ->
      pairs = document.cookie.split('; ')
      for pair in pairs
        val = pair.split('=')
        if decodeURIComponent(val[0]) is key
          return decodeURIComponent(val[1] or '')
      null

    # Set a session cookie

    setCookie: (key, value, options = {}) ->
      payload = "#{encodeURIComponent(key)}=#{encodeURIComponent(value)}"
      getOption = (name) ->
        if options[name] then "; #{name}=#{options[name]}" else ''

      expires = if options.expires
        "; expires=#{options.expires.toUTCString()}"
      else
        ''

      document.cookie = [
        payload, expires,
        (getOption 'path'), (getOption 'domain'), (getOption 'secure')
      ].join('')

    expireCookie: (key) ->
      document.cookie = "#{key}=nil; expires=#{(new Date).toGMTString()}"

  utils
