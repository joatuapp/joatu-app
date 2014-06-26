module PagedProperties
  extend ActiveSupport::Concern
  
  included do |base|
    base.property :object, getter: lambda {|*| "collection" }, writeable: false
    base.property :current_page, writeable: false
    base.property :size, as: :total_items, writeable: false
    base.property :total_pages, writeable: false
  end
end
