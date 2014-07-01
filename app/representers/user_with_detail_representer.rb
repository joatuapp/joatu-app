class UserWithDetailRepresenter < ApplicationRepresenter
  property :id, writeable: false
  property :username
  property :email
  property :primary_community_id, as: :community_id
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

  property :profile_image_url_tiny
  property :profile_image_url_thumbnail

  property :created_at, writeable: false
  property :updated_at, writeable: false
end
