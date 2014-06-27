# == Schema Information
#
# Table name: user_details
#
#  id                   :uuid             not null, primary key
#  user_id              :uuid
#  primary_community_id :uuid
#  given_name           :string(128)
#  surname              :string(128)
#  birth_date           :date
#  sex                  :string(32)
#  current_location     :spatial          point, 4326
#  postal_code          :string(32)
#  neighbourhood        :string(128)
#  city                 :string(128)
#  province             :string(128)
#  country              :string(128)
#  created_at           :datetime
#  updated_at           :datetime
#  deleted_at           :datetime
#

class UserDetail < ActiveRecord::Base
  acts_as_paranoid

  include HasLatLngAccessiblePoint
  lat_lng_accessible_point_columns :current_location

  belongs_to :user
  belongs_to :primary_community, class: Community
end
