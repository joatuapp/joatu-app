class SearchController < ApiController

  before_action :authenticate_user!
  skip_after_action :verify_authorized
  after_action :verify_policy_scoped

  def offers
    query = Offer::Base.includes(user: [:detail])
    # NOTE: Commented out by Alex W, Nov 24,2014 at Jamie's request, to
    # fascilitate testing with very few people / offers. We would probably want
    # a more elaborate search algorythm for real use anyway.
    #if community_id = current_user.primary_community_id
      #query = query.where('users.primary_community_id' => community_id)
    #end
    unless params[:search].blank?
      tag_query = query.tagged_with(URI.unescape params[:search])
      if tag_query.size > 0
        query = tag_query
      else
        query = query.where("offers.title ILIKE ? OR offers.description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      end
    end
    @offers = policy_scope(query)
    respond_with @offers.page(params[:page]), represent_with: SearchResultsRepresenter
  end
end
