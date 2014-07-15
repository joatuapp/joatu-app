class SearchController < ApiController

  before_action :authenticate_user!
  skip_after_action :verify_authorized
  after_action :verify_policy_scoped

  def offers
    query = Offer::Base.includes(:user)
    if params[:search]
      query = query.tagged_with(params[:search])
    end
    if community = current_user.primary_community
      query = query.where('users.primary_community_id' => community.id)
    end
    @offers = policy_scope(query)
    respond_with @offers.page(params[:page]), represent_with: OffersRepresenter
  end
end
