class Community < ActiveRecord::Base

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

  # These lat/lng accessors are for both
  # convenience and also are used by the
  # rails_admin gem to let us easily set locaitons
  # in the admin interface.
  def latitude
    location ? location.y : nil
  end

  def longitude
    location ? location.x : nil
  end

  def latitude=(lat)
    @latitude = lat
    update_location
  end

  def longitude=(lng)
    @longitude = lng
    update_location
  end

  protected

  def update_location
    self.location = "POINT(#{@longitude} #{@latitude})" if @latitude && @longitude
  end
end
