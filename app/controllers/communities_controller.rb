class CommunitiesController < ApiController
  represents :json, entity: CommunityRepresenter, collection: CommunitiesRepresenter

  load_and_authorize_resource

  def index
    respond_with @communities.page params[:page]
  end
end
