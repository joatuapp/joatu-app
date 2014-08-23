define [
  'views/base/collection_view'
  'views/tag_view'
], (CollectionView, TagView) ->
  'use strict'

  class TagsView extends CollectionView
    itemView: TagView
    templateName: 'tags'
    listSelector: '.tags'
    fallbackSelector: '.empty'
