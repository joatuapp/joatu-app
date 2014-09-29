module JoatuApp
  class Application
    config.action_mailer.default_url_options = {
      host: ENV.fetch('APP_HOST')
    }

    config.action_mailer.smtp_settings = {
      address: 'smtp.mandrillapp.com',
      port: 587,
      user_name: 'info@joatu.com',
      password: ENV.fetch('SMTP_PASSWORD'),
      authentication: :login,
      enable_starttls_auto: true,
      domain: ENV.fetch('APP_HOST'),
    }
  end
end
