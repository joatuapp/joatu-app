class SearchResultsRepresenter < ApplicationCollectionRepresenter
  decorator = lambda { |item, *| "#{item.class.name}SearchResultRepresenter".constantize }
  klass = lambda { |json_item, *| json_item.object ? json_item.object.camelize : nil }

  # Overrides the normal items collection to return results
  # represented with a SearchResult version of their representer.
  collection :items, decorator: decorator, class: klass, exec_context: :decorator
end
