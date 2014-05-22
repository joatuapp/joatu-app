class CommunityRepresenter < ApplicationRepresenter
  property :id
  property :name
  property :location_latitude, as: :latitude
  property :location_longitude, as: :longitude
end
