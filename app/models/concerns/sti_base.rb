module StiBase
  extend ActiveSupport::Concern

  module ClassMethods
    # This method identifies the calling class as an STI base class following the convention that the base class
    # and all it's children are together in a folder. Based on that information it adds several methods to the base
    # class (and so to all child classes.
    #
    # The method takes an options array supporing just one option, "include_base". If given, this option specifies that
    # methods that consider the collection of STI types should consider the base class as well, using the value given
    # for the include_base key as the "name" for hte base class.
    def acts_as_sti_base(options = {})

      # Creates the "types" method, which returns a hash of all the valid types for this STI instance based on which files
      # exist in the folder where the including file lives. If include_base is set this hash will include the base class.
      # The hash is keyed after the file name, except in the case of the base class which (if present) will be keyed with
      # the value of the include_base option. The hash's values are the string versions of the STI class names.
      metaclass.instance_eval do
        define_method :types do
          unless @types
            @types ||= {}
            class_name = self.name
            folder_name = class_name.split('::').first.underscore
            Dir.glob(Rails.root.join('app', 'models', folder_name, '*.rb')) do |full_file_name|
              file_name = File.basename(full_file_name, ".*")
              if file_name == "base"
                next unless options[:include_base]
                key_name = options[:include_base]
              else
                key_name = file_name
              end
              @types[key_name.to_sym] = "#{folder_name.camelize}::#{file_name.camelize}"
            end
            @types
          end
          @types
        end
      end
    end

    def metaclass
      class << self; self; end
    end
  end
end
