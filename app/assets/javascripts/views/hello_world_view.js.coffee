define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class HelloWorldView extends View

    templateName: 'hello_world'

    className: 'hello-world'

    region: "main"

    # Automatically render after initialize
    autoRender: true
