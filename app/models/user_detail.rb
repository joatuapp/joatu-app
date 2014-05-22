class UserDetail < ActiveRecord::Base
  
  include HasLatLngAccessiblePoint
  lat_lng_accessible_point_columns :current_location

  belongs_to :user

  validates :primary_community_id, presence: true
end
