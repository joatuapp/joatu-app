class UsersController < ApiController
  # TODO: Uncomment this!
  # before_filter :authenticate_user!

  def me
    authorize current_user
    respond_with current_user
  end

  def show
    @user = User.includes(:detail).find(params[:id])
    authorize @user
    respond_with @user
  end
end
