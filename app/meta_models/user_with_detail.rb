class UserWithDetail
  include Associates

  associate :user
  associate :user_detail, depends_on: :user, except: [:id, :user_id, :created_at, :updated_at]

  delegate :active_for_authentication?, to: :user
  delegate :current_location_latitude, :current_location_longitude, to: :user_detail

  def password
    user.password
  end

  def password= (value)
    user.password = value
    user.password_confirmation = value
  end
end
