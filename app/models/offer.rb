# == Schema Information
#
# Table name: offers
#
#  id                :uuid             not null, primary key
#  user_id           :uuid
#  offer_category_id :uuid
#  title             :string(128)
#  summary           :string(255)
#  description       :text
#  location          :spatial          point, 4326
#  address1          :string(128)
#  address2          :string(128)
#  postal_code       :string(32)
#  neighbourhood     :string(128)
#  city              :string(128)
#  province          :string(128)
#  country           :string(128)
#  timeframe         :string(128)
#  length            :integer
#  created_at        :datetime
#  updated_at        :datetime
#  deleted_at        :datetime
#

class Offer < ActiveRecord::Base
  acts_as_paranoid

  include HasLatLngAccessiblePoint
  lat_lng_accessible_point_columns :location

  belongs_to :offer_category
  belongs_to :user

  default_scope { includes(:offer_category) }

  def category_name
    offer_category ? offer_category.name : nil
  end
end
