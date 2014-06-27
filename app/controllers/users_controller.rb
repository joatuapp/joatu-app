class UsersController < ApiController
  before_filter :authenticate_user!

  def me
    authorize current_user, :show?
    respond_with current_user
  end

  def show
    user = User.find(params[:id])
    @user = UserWithDetail.new(user: user, user_detail: user.detail)
    authorize @user.user
    respond_with @user
  end

  def update
    user = User.find(params[:id])
    @user = UserWithDetail.new(user: user, user_detail: user.detail)
    @user = consume! @user
    respond_with @user.save
  end
end
