class UserRepresenter < Roar::Decorator
  include Roar::Representer::JSON

  property :object, decorator_scope: true
  property :id
  property :given_name
  property :surname
  property :email
  property :current_location

  def object
    "user"
  end
end
