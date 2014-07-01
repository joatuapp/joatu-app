module JoatuApp
  class Application
    config.action_mailer.default_url_options = {
      host: ENV['APP_HOST'] || "localhost:8080"
    }
  end
end
