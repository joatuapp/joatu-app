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
      @field_name = options.field_name || "tags"
      @field_id = options.field_id || @field_name
      @label = options.label || "Tags"

      @listenTo @collection, "add", @collectionUpdateHandler
      @listenTo @collection, "remove", @collectionUpdateHandler
      
    render: ->
      super
      tagsInputOptions = {
        # Confirm on enter, tab, or comma (respectively)
        confirmKeys: [13, 9, 188] 
        itemValue: 'tag'
      }

      @tagsInputs = @$el.find("select[multiple][data-role=tagsinput]").tagsinput(tagsInputOptions)
      window.ti = @tagsInputs

    getTemplateData: ->
      model_data = super
      $.extend({}, model_data, {field_name: @field_name, label: @label, field_id: @field_id})

    collectionUpdateHandler: (model, collection, options) =>
      if @tagsInputs
        _.each @tagsInputs, (tagInput) ->
          tagInput.add(model.attributes)

    dispose: ->
      if @tagsInputs
        _.each @tagsInputs, (tagInput) ->
          tagInput.destroy()
      super
