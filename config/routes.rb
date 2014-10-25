Rails.application.routes.draw do

  api_actions = [:index, :show, :create, :update, :destroy]

  # Admin routes:
  devise_for :admins
  if defined? RailsAdmin
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  # Front page (index) route:
  root 'index#index'

  # API Routes:
  if ENV.key? "API_SUBDOMAIN"
    consts = {
      subdomain: ENV.fetch("API_SUBDOMAIN")
    }
  end
  constraints(consts || {}) do
    devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations', confirmations: 'confirmations' }

    get 'search/:action', controller: :search

    resources :communities

    get 'users/me' => 'users#me'
    resources :users, only: api_actions do
      resources :offers, only: [:index, :create]
    end

    get 'offers/types' => 'offers#types'
    resources :offers, only: [:show, :update, :destroy]
  end

  # This is at the very end of the file
  # as it needs to match anything not explicitly routed, 
  # and redirect it (if GET and format = HTML) to 
  # the index page.
  get "*page" => "index#index", constraints: lambda{|req| req.format == :html }
end
