class UserWithDetail
  include Associates

  associate :user
  associate :user_detail, depends_on: :user, except: [:id, :user_id, :created_at, :updated_at]

  delegate :current_location_latitude, :current_location_longitude, to: :user_detail
end
