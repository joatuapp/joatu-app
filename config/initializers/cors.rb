
module JoatuApp
  class Application
    config.middleware.insert_before Rack::Runtime, Rack::Cors do
      allow do
        allowed_origins = ENV.fetch("CORS_ORIGINS").split(',')
        origins allowed_origins
        resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options, :head], credentials: false
      end
    end
  end
end
