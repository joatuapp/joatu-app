class UsersController < ApiController
  before_filter :authenticate_user!

  def me
    authorize current_user, :show?
    respond_with current_user
  end

  def show
    scope = User
    if params[:detail]
      scope = scope.includes(:detail)
    end
    @user = scope.find(params[:id])
    authorize @user
    respond_with @user, expand_detail: !!params[:detail]
  end
end
