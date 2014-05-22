class UserDetailRepresenter < ApplicationRepresenter
  property :user_id
  property :primary_community_id, as: :community_id
  property :given_name
  property :surname
  property :birth_date
  property :sex
  property :current_location
  property :postal_code
  property :neighbourhood
  property :city
  property :province
  property :country
end
