class Offer < ActiveRecord::Base
  acts_as_paranoid

  include HasLatLngAccessiblePoint
  lat_lng_accessible_point_columns :location

  belongs_to :offer_category
  belongs_to :user

  default_scope { includes(:offer_category) }

  def category_name
    offer_category.name
  end
end
