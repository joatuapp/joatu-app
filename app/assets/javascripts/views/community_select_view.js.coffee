define [
  'views/base/collection_view'
  'views/community_option'
], (CollectionView, CommunityOption, template) ->
  'use strict'

  class CommunitySelectView extends CollectionView
    noWrap: true
    templateName: 'community_select'
    itemView: CommunityOption
    listSelector: '[name=community_id]'
    fallbackSelector: '#no-communities'
