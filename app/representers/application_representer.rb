class ApplicationRepresenter < Roar::Decorator
  include Roar::Representer::JSON

  property :object, decorator_scope: true, writeable: false

  def object
    represented.class.name.downcase
  end
end
