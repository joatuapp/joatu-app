define [
  'views/base/view'
  'views/community_select_view'
  'models/communities'
], (View, CommunitySelectView, Communities, template) ->
  'use strict'

  class RegisterStep2View extends View
    templateName: 'register_step2'
    className: 'step2-content'

    regions:
      communitySelect: "#community_select_container"

    attach: (options) ->
      super
      @communitySelect = new CommunitySelectView region: 'communitySelect', collection: new Communities
      @subview 'communitySelect', @communitySelect
