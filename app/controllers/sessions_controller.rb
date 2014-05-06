class SessionsController < ApiController
  def create
    user = User.find_for_database_authentication(email: params[:email])
   
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
    render json: {errors: {login: ["Error with your email or password"]}}, status: :unauthorized
  end
end
