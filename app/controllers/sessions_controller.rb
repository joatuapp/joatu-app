class SessionsController < ApiController

  skip_after_action :verify_authorized

  def create
    user = User.find_for_database_authentication(login: params[:login])

    if user && user.valid_password?(params[:password])
      sign_in(:user, user)
      user_with_detail = UserWithDetail.new user: user, user_detail: user.detail
      respond_with user_with_detail, represent_with: UserSessionRepresenter, status: :created
    else
      invalid_login_attempt
    end
  end

  def destroy
    return head :unauthorized unless current_user
    current_user.reset_authentication_token!
    sign_out(:user)
    head :no_content
  end
   
  protected
   
  def invalid_login_attempt
    warden.custom_failure!
    render json: {error: "Error with your username / email or password"}, status: :unauthorized
  end
end
