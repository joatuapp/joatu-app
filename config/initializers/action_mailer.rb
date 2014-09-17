module JoatuApp
  class Application
    config.action_mailer.default_url_options = {
      host: ENV.fetch('APP_HOST')
    }
  end
end
