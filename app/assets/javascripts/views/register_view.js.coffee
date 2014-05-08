define [
  'views/base/view'
  'views/register_step1_view'
  'views/register_step2_view'
  'views/register_step3_view'
], (View, RegisterStep1View, RegisterStep2View, RegisterStep3View, template) ->
  'use strict'

  class RegisterView extends View
    templateName: 'register'
    className: 'row register'

    regions:
      step1: "#step1"
      step2: "#step2"
      step3: "#step3"

    render: ->
      super
      step1 = new RegisterStep1View autoRender: true, region: 'step1'
      @subview 'step1', step1
      step2 = new RegisterStep2View autoRender: true, region: 'step2'
      @subview 'step2', step2
      step3 = new RegisterStep3View autoRender: true, region: 'step3'
      @subview 'step3', step3
