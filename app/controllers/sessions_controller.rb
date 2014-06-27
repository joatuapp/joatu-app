class SessionsController < ApiController

  skip_after_action :verify_authorized

  def create
    user = User.find_for_database_authentication(login: params[:login])
   
    if user && user.valid_password?(params[:password])
      sign_in("user", user)
      respond_with user, represent_with: UserSessionRepresenter
    else
      invalid_login_attempt
    end
  end

  def destroy
    current_user.reset_authentication_token!
    sign_out("user")
    head :no_content
  end
   
  protected
   
  def invalid_login_attempt
    warden.custom_failure!
    render json: {errors: {login: ["Error with your username / email or password"]}}, status: :unauthorized
  end
end
