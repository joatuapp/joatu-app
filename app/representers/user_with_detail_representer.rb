class UserWithDetailRepresenter < ApplicationRepresenter
  property :id, writeable: false
  property :username
  property :email
  property :primary_community_id, as: :community_id
  property :given_name
  property :surname
  property :birth_date
  property :sex
  property :current_location_latitude, as: :latitude
  property :current_location_longitude, as: :longitude
  property :postal_code
  property :neighbourhood
  property :city
  property :province
  property :country
end
