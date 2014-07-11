define [
  'views/base/collection_view'
  'views/tag_view'
], (CollectionView, TagView) ->
  'use strict'

  class TagsView extends CollectionView
    className: 'tags list-inline'
    tagName: 'ul'
    itemView: TagView
