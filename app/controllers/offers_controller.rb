class OffersController < ApiController

  skip_after_action :verify_authorized, only: :types

  def index
    @offers = policy_scope(Offer).where(user_id: params[:user_id])
    respond_with @offers.page(params[:page])
  end

  def create
    @offer = Offer.new
    consume! @offer
    @offer.user_id = current_user.id
    authorize @offer
    @offer.save
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
    @offer.save
    respond_with @offer
  end

  def destroy
    @offer = Offer.find(params[:id])
    authorize @offer
    @offer.destroy
    head :no_content
  end

  def types
    @types = Offer::Base.types.inject({}) { |h, (type, klass)| h[klass] = type.to_s.pluralize.humanize; h }
    respond_with @types, represent_with: TypesRepresenter
  end
end
