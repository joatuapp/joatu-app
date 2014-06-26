Rails.application.routes.draw do

  # Admin routes:
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Front page (index) route:
  root 'index#index'

  # API Routes:
  constraints(subdomain: ENV["API_SUBDOMAIN"] || 'api') do
    devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

    resources :communities

    resources :users
    get 'users/me' => 'users#me'
  end

  # This is at the very end of the file
  # as it needs to match anything not explicitly routed, 
  # and redirect it (if GET and format = HTML) to 
  # the index page.
  get "*page" => "index#index", constraints: lambda{|req| req.format == :html }
end
