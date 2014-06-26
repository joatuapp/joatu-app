class UserDetail < ActiveRecord::Base
  acts_as_paranoid

  include HasLatLngAccessiblePoint
  lat_lng_accessible_point_columns :current_location

  belongs_to :user
  belongs_to :primary_community, class: Community
end
