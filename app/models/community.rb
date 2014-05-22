class Community < ActiveRecord::Base

  def self.near(wkt_point, distance_in_meters = 5000)
    if wkt_point
      where(%{
        ST_DWithin(
          location,
          ST_GeographyFromText('SRID=4326;%s'),
          %d
        )
      } % [wkt_point, distance_in_meters])
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
