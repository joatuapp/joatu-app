class RemoveOfferCategories < ActiveRecord::Migration
  def change
    drop_table :offer_categories
    remove_column :offers, :offer_category_id, :uuid
  end
end
