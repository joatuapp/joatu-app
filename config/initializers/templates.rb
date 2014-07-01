module JoatuApp
  class Application
    
    # Uglify HAML templates
    if defined? ::HamlCoffeeAssets
      config.hamlcoffee.uglify = true
    end
    
    config.after_initialize do
      # CoffeeScript compilation: Do not wrap the code in a closure
      ::Tilt::CoffeeScriptTemplate.default_bare = true

      # Use Almond as AMD loader
      #config.requirejs.loader = :almond

    end
  end
end
