# -*- mode: ruby -*-
# vi: set ft=ruby :
source 'https://rubygems.org'

gem 'rails', '~> 4.1'
gem 'pg' # Postgres
gem 'rgeo' # Geo-data, for use with postgres
gem 'activerecord-postgis-adapter'
gem 'annotate' # Annotates models with db schema.
gem 'acts-as-taggable-on' # Models can be taggable.
gem 'paranoia', '~> 2.0' # Paranoid delete
gem 'roar-rails' # Representer library
gem 'bcrypt-ruby', '~> 3.1.2'
gem 'kaminari' # Pagnination gem
gem 'devise' # Authentication
gem 'devise-token_authenticatable' # Token auth.
gem 'pundit' # Authorization
# gem 'associates', github: 'phildionne/associates'
gem 'associates', github: 'undergroundwebdesigns/associates' # Meta-models
gem 'rack-cors', require: 'rack/cors'
gem 'unicorn' # Rails server.
gem 'requirejs-rails', github: 'jwhitley/requirejs-rails'
gem 'haml'
gem 'i18n-js' # I18n for JS files.
gem 'paperclip', '~> 4.1' # Attachment handling (images).
gem 'foreman'
gem 'sprockets-rails', :require => 'sprockets/railtie'

group :admin, :development, :production do
  gem 'rails_admin'
  gem 'rails_admin_pundit', :github => 'sudosu/rails_admin_pundit'
  gem 'rails_admin_map_field', :github => 'sudosu/rails_admin_map_field'
end

gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'
gem 'sass-rails'
gem 'coffee-rails'
#gem 'compass-rails'
gem 'haml_coffee_assets', github: 'netzpirat/haml_coffee_assets'
gem 'uglifier'

gem 'mail_safe', '~> 0.3', group: [:development, :staging]

gem 'non-stupid-digest-assets'

group :development do
  gem 'coffee-rails-source-maps'
  gem 'thor'
  gem 'childprocess'

  # Guard watches for file changes and automatically re-runs
  # tests. Brakeman watches for potential security issues.
  gem 'guard'
  gem 'guard-ctags-bundler'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  gem 'guard-coffeescript'
  gem 'brakeman', :require => false
  gem 'guard-brakeman'

  # Byebug is a debugger
  gem 'byebug'

  # Capistrano for deploys
  gem 'capistrano', '~> 3.2.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-chef'
  gem 'capistrano-ci'

  # These are gems that aren't used by the app,
  # but are included in the gemfile because they're
  # used by our coding process.
  gem 'travis', require: false
  gem 'pivotal-integration', require: false, github: 'undergroundwebdesigns/pivotal-integration'
end

group :test, :development do
  gem 'spring-commands-rspec'
  gem 'rspec'
  gem 'rspec-rails', '~> 2.0'
  gem 'rspec_api_documentation'

  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'

  gem 'codeclimate-test-reporter', require: nil
  
  # Dotenv loads env variables from a .env file when the
  # environment is bootstraped (eg, through foreman).
  gem 'dotenv-deployment'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
