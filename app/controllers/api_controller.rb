class ApiController < ApplicationController
  # Mixes in Roar to the controllers
  include Roar::Rails::ControllerAdditions
  # Mix in Pundit
  include Pundit

  respond_to :json

  after_action :verify_authorized
  after_action :verify_policy_scoped, :only => :index
end
