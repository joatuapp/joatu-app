define [
  'views/base/collection_view'
], (CollectionView, template) ->
  'use strict'

  class CommunitySelectView extends CollectionView
    noWrap: true
    templateName: 'community_select'
    itemView: 'community_option'
    listSelector: '[name=community_id]'
