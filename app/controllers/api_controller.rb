class ApiController < ApplicationController
  respond_to :json
  
  # Mixes in Roar to the controllers
  include Roar::Rails::ControllerAdditions
end
