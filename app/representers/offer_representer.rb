class OfferRepresenter < ApplicationRepresenter
  property :id, writeable: false 
  property :user_id
  property :title
  property :summary
  property :description
  property :location_latitude
  property :location_longitude
  property :address1
  property :address2
  property :neighbourhood
  property :postal_code
  property :city
  property :province
  property :country

  property :timeframe
  property :length

  property :tag_list, as: :tags

  property :created_at, writeable: false
  property :updated_at, writeable: false
end
