class UsersController < ApiController

  before_action :authenticate_user!

  def me
    authorize current_user, :show?
    @user = UserWithDetail.new(user: current_user, user_detail: current_user.detail)
    respond_with @user
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
    authorize @user.user
    @user = consume! @user
    @user.save
    respond_with @user
  end
end
