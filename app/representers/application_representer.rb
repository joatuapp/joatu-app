class ApplicationRepresenter < Roar::Decorator
  include Roar::Representer::JSON

  property :object, exec_context: :decorator, writeable: false

  def object
    represented.class.name.downcase
  end
end
