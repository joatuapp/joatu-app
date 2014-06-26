class ApplicationRepresenter < Roar::Decorator
  include Roar::Representer::JSON

  property :object, decorator_scope: true, writeable: false

  property :created_at, writeable: false
  property :updated_at, writeable: false

  def object
    represented.class.name.downcase
  end
end
