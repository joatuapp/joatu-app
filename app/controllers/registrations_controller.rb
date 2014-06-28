class RegistrationsController < ApiController

  def create
    user = User.new
    authorize user
    user_with_detail = UserWithDetail.new user: user, user_detail: user.build_detail
    user_with_detail = consume! user_with_detail
    user.password = user.password_confirmation = params[:password]
    user.email_confirmation = params[:email_confirmation]

    if user_with_detail.save
      if user.active_for_authentication?
        sign_in('user', user)
      else
        expire_session_data_after_sign_in!
      end
    else
      user.clean_up_passwords
    end
    respond_with user_with_detail, represent_with: UserSessionRepresenter
  end
end
