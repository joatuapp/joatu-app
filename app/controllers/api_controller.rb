class ApiController < ApplicationController
  # Mixes in Roar to the controllers
  include Roar::Rails::ControllerAdditions

  respond_to :json

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
end
