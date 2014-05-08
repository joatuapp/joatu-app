class ApplicationRepresenter < Roar::Decorator
  include Roar::Representer::JSON

  property :object, decorator_scope: true

  def object
    represented.class.name.downcase
  end
end
