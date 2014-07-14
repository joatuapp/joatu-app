module PagedRepresenter
  extend ActiveSupport::Concern
  include PagedProperties

  included do |base|
    decorator = lambda { |item, *| "#{item.class.name}Representer".constantize }
    klass = lambda { |json_item, *| json_item.object ? json_item.object.camelize : nil }

    # Adds the items collection
    # to the representer
    base.collection :items, decorator: decorator, class: klass, exec_context: :decorator

    base.class_eval do
      def items
        represented
      end
    end
  end
end
