class OfferRepresenter < ApplicationRepresenter
  property :id, writeable: false 
  property :user_id
  property :offer_category, as: :category do
    property :id, writer: lambda {|doc, args| doc["offer_category_id"] = id}
    property :name, writeable: false
  end

  property :title
  property :description
  property :latitude
  property :longitude
  property :address1
  property :address2
  property :neighbourhood
  property :postal_code
  property :city
  property :province
  property :country

  property :timeframe
  property :length
end
