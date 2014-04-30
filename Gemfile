# -*- mode: ruby -*-
# vi: set ft=ruby :
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1'

# Use postgres as the database for Active Record
gem 'pg'

# Geo data gem
gem 'rgeo'

# Activerecord adapter that supports postgis, the postgres geo plugin.
gem 'ar-postgis', require: 'activerecord-postgis-adapter'

# Active record support gems.
gem 'migration_comments'
gem 'annotate'

# Paranoia causes destroy calls to set a
# "deleted_at" timestamp rather than actually deleting anything. Allows us to recover deleted data later.
gem 'paranoia', '~> 2.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'roar-rails'
gem 'jbuilder'

gem 'bcrypt-ruby', '~> 3.1.2'

# Kaminari handles pagination.
gem 'kaminari'

# Devise handles authentication
gem 'devise'
gem 'devise-token_authenticatable'
# gem 'koala', '~> 1.8.0rc1' # Commenting, might not need

# Cancancan for authorization
gem 'cancancan'

# Cors extension for rack, let's us do cross domain JS requests:
gem 'rack-cors', require: 'rack/cors'

gem 'unicorn'

gem 'haml'

group :admin, :development, :test do
  gem 'rails_admin'
  gem "rails_admin_map_field", :github => "sudosu/rails_admin_map_field"
end

group :production do
  # New Relic (tracking & analytics)
  gem "newrelic_rpm"
end

gem 'requirejs-rails', github: 'jwhitley/requirejs-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  #gem 'compass-rails'
  gem 'haml_coffee_assets'
  gem 'uglifier'
end


group :development do
  gem 'foreman'

  # Thor (uses childpress) and provides us with
  # easy to write setup scripts.
  gem 'thor'
  gem 'childprocess'

  # Guard watches for file changes and automatically re-runs
  # tests. Brakeman watches for potential security issues.
  gem 'guard'
  gem 'guard-ctags-bundler'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  gem 'brakeman', :require => false
  gem 'guard-brakeman'

  # Byebug is a debugger
  gem 'byebug'

  # Capistrano for deploys
  gem 'capistrano', '~> 3.2.0'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  # Commenting out right now so that
  # it doesn't bug us about knife configs.
  # We're not at the chef / cap stage
  # yet, so we don't care.
  # gem 'capistrano-chef'
end

# These gems are required for testing and to run seeds:
group :seed, :test, :development do
  gem 'factory_girl_rails', "~> 4.0"
  gem 'faker'
end

group :test, :development do
  gem 'rspec'
  gem 'rspec-rails', '~> 2.0'
  # gem 'spork', '~> 1.0rc'
  # gem 'guard-spork'
  gem 'rspec_api_documentation'
  
  # Dotenv loads env variables from a .env file when the
  # environment is bootstraped (eg, through foreman).
  gem 'dotenv-rails'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
