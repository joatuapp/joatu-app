class UserWithDetailRepresenter < ApplicationRepresenter
  property :id, writeable: false
  property :username
  property :email
  property :primary_community_id, as: :community_id
  property :community_name, writeable: false, default: "<unknown>"
  property :given_name
  property :surname
  property :about_me
  property :birth_date
  property :sex
  property :current_location_latitude, as: :latitude
  property :current_location_longitude, as: :longitude
  property :postal_code
  property :neighbourhood
  property :city
  property :province
  property :country

  property :accepted_currency_list, as: :accepted_currencies

  property :profile_image_url_tiny, writeable: false
  property :profile_image_url_thumbnail, writeable: false

  property :created_at, writeable: false
  property :updated_at, writeable: false
end
