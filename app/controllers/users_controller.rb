class UsersController < ApiController
  before_filter :authenticate_user!

  def me
    authorize! :read, current_user
    respond_with current_user
  end
end
