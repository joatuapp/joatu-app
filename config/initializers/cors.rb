
module JoatuApp
  class Application
    config.middleware.insert_before Rack::Runtime, Rack::Cors do
      allow do
        allowed_origins = ENV["CORS_ORIGINS"] ? ENV["CORS_ORIGINS"].split(',') : nil
        origins allowed_origins
        resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options, :head], credentials: false
      end
    end
  end
end
