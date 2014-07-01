Rails.application.routes.draw do

  api_actions = [:index, :show, :create, :update, :destroy]

  # Admin routes:
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Front page (index) route:
  root 'index#index'

  # API Routes:
  constraints(subdomain: ENV["API_SUBDOMAIN"] || 'api') do
    devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

    resources :communities

    get 'users/me' => 'users#me'
    resources :users, only: api_actions do
      resources :offers, only: api_actions
    end
  end

  # This is at the very end of the file
  # as it needs to match anything not explicitly routed, 
  # and redirect it (if GET and format = HTML) to 
  # the index page.
  get "*page" => "index#index", constraints: lambda{|req| req.format == :html }
end
