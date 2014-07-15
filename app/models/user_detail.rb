# == Schema Information
#
# Table name: user_details
#
#  id               :uuid             not null, primary key
#  user_id          :uuid
#  given_name       :string(128)
#  surname          :string(128)
#  birth_date       :date
#  sex              :string(32)
#  current_location :spatial          point, 4326
#  postal_code      :string(32)
#  neighbourhood    :string(128)
#  city             :string(128)
#  province         :string(128)
#  country          :string(128)
#  created_at       :datetime
#  updated_at       :datetime
#  deleted_at       :datetime
#  about_me         :text
#  profile_image_id :uuid
#
# Indexes
#
#  index_user_details_on_current_location  (current_location)
#  index_user_details_on_user_id           (user_id)
#

class UserDetail < ActiveRecord::Base
  acts_as_paranoid

  include HasLatLngAccessiblePoint
  lat_lng_accessible_point_columns :current_location

  belongs_to :profile_image, class: Image, foreign_key: :profile_image_id
  belongs_to :user

  validates :user, presence: true

  def profile_image
    self[:profile_image] || Image.new
  end
end
