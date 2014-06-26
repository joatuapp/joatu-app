class CommunitiesController < ApiController
  def index
    respond_with @communities.near(params[:latitude], params[:longitude], params[:distance]).page(params[:page])
  end
end
