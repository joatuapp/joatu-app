define [
  'views/base/collection_view'
  'views/tag_option_view'
], (CollectionView, TagOptionView, template) ->
  'use strict'

  class TagSelectView extends CollectionView
    autoRender: true
    templateName: 'tag_select'
    itemView: TagOptionView
    listSelector: 'select[multiple][data-role=tagsinput]'

    initialize: (options) ->
      super
      @fieldName = options.fieldName || "tags"
      @fieldId = options.fieldId || @fieldName

      @options = options
      
    render: ->
      super
      tagsInputOptions = $.extend({}, @options, {
        # Confirm on enter, tab, or comma (respectively)
        confirmKeys: [13, 9, 188] 
      })

      @tagsInputs = @$el.find("select[multiple][data-role=tagsinput]").tagsinput(tagsInputOptions)
      _.each @tagsInputs, (input) =>
        input.removeAll()
        @collection.each (model) =>
          input.add(model.get('tag'))

      @listenTo @collection, "add", @collectionUpdateHandler
      @listenTo @collection, "remove", @collectionUpdateHandler

    getTemplateData: ->
      model_data = super
      $.extend({}, model_data, {fieldName: @fieldName, fieldId: @fieldId})

    collectionUpdateHandler: (model, collection, options) =>
      if @tagsInputs
        _.each @tagsInputs, (tagInput) ->
          tagInput.add(model.get('tag'))

    dispose: ->
      if @tagsInputs
        _.each @tagsInputs, (tagInput) ->
          tagInput.destroy()
      super
