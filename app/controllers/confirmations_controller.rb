class ConfirmationsController < ApiController

  def show
    user = User.confirm_by_token(params[:confirmation_token])
    user.build_detail unless user.detail
    user_with_detail = UserWithDetail.new user: user, user_detail: user.detail
    authorize user, :confirm?
    respond_with user_with_detail, represent_with: UserSessionRepresenter
  end
  alias :create :show
end
