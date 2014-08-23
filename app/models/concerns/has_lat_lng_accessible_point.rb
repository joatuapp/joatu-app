module HasLatLngAccessiblePoint
  extend ActiveSupport::Concern

  module ClassMethods
    def lat_lng_accessible_point_columns(columns)
      Array(columns).each do |col|
        col_mappings = {latitude: :y, longitude: :x}

        col_mappings.each do |method_suffix, getter|
          define_method "#{col}_#{method_suffix}" do
            self.send(col) ? self.send(col).send(getter) : instance_variable_get("@#{col}_#{method_suffix}")
          end
        end

        col_mappings.each do |method_suffix, getter|
          define_method "#{col}_#{method_suffix}=" do |val|
            instance_variable_set("@#{col}_#{method_suffix}", val)
            send("update_#{col}")
          end
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
