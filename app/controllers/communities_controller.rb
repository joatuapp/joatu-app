class CommunitiesController < ApiController
  represents :json, entity: CommunityRepresenter, collection: CommunitiesRepresenter

  load_and_authorize_resource

  def index
    respond_with @communities.near(params[:point]).page(params[:page])
  end
end
