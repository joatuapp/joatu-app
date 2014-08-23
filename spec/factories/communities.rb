# == Schema Information
#
# Table name: communities
#
#  id         :uuid             not null, primary key
#  name       :string(128)
#  location   :spatial          point, 4326
#  created_at :datetime
#  updated_at :datetime
#  deleted_at :datetime
#
# Indexes
#
#  index_communities_on_location  (location)
#

FactoryGirl.define do
  factory :community do
  end
end
