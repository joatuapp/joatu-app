class Community < ActiveRecord::Base
  acts_as_paranoid

  include HasLatLngAccessiblePoint
  lat_lng_accessible_point_columns :location

  def self.near(latitude = nil, longitude = nil, distance_in_meters = nil)
    # Default distance if not given (or given with nil)
    # is 5km.
    distance_in_meters ||= 5000

    if latitude && longitude
      where(%{
        ST_DWithin(
          location,
          ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
          %d
        )
      } % [longitude, latitude, distance_in_meters])
    else
      self
    end
  end
end
