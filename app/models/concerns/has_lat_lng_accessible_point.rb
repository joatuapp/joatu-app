module HasLatLngAccessiblePoint
  extend ActiveSupport::Concern

  module ClassMethods
    def lat_lng_accessible_point_columns(columns)
      Array(columns).each do |col|
        define_method "#{col}_latitude" do
          self.send(col) ? self.send(col).y : instance_variable_get("@#{col}_latitude")
        end

        define_method "#{col}_longitude" do
          self.send(col) ? self.send(col).x : instance_variable_get("@#{col}_longitude")
        end

        define_method "#{col}_latitude=" do |val|
          instance_variable_set("@#{col}_latitude", val)
          send("update_#{col}")
        end

        define_method "#{col}_longitude=" do |val|
          instance_variable_set("@#{col}_longitude", val)
          send("update_#{col}")
        end

        define_method "update_#{col}" do
          lat = instance_variable_get("@#{col}_latitude")
          lng = instance_variable_get("@#{col}_longitude")
          self.send("#{col}=", "POINT(#{lng} #{lat})") if lat && lng
        end
      end
    end
  end
end
