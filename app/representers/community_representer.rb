class CommunityRepresenter < ApplicationRepresenter
  property :id
  property :name
  property :location_latitude, as: :latitude
  property :location_longitude, as: :longitude

  property :created_at, writeable: false
  property :updated_at, writeable: false
end
