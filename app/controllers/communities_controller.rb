class CommunitiesController < ApiController
  def index
    @communities = policy_scope(Community.near(params[:latitude], params[:longitude], params[:distance])).page(params[:page])
    respond_with @communities
  end
end
