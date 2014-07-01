class OffersController < ApiController
  def index
    @offers = policy_scope(Offer).where(user_id: params[:user_id])
    respond_with @offers.page(params[:page])
  end

  def create
    @offer = Offer.new
    consume! @offer
    @offer.user_id = current_user.id
    authorize @offer
    respond_with @offer
  end

  def show
    @offer = Offer.find(params[:id])
    authorize @offer
    respond_with @offer
  end

  def update
    @offer = Offer.find(params[:id])
    consume! @offer
    authorize @offer
    respond_with @offer
  end

  def destroy
    @offer = Offer.find(params[:id])
    authorize @offer
    @offer.destroy
    head :no_content
  end
end
