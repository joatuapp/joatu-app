module PagedProperties
  extend ActiveSupport::Concern
  
  included do |base|
    base.property :object, getter: lambda {|*| "collection" }
    base.property :current_page
    base.property :size, as: :total_items
    base.property :total_pages
  end
end
