class RegistrationsController < ApiController

  def create
    user = consume! User.new
    user.password = user.password_confirmation = params[:password]

    if user.save
      if user.active_for_authentication?
        sign_in('user', user)
      else
        expire_session_data_after_sign_in!
      end
    else
      user.clean_up_passwords
    end
    respond_with user, represent_with: UserSessionRepresenter
  end
end
