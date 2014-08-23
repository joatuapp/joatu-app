class AddTypeToOffers < ActiveRecord::Migration
  def change
    change_table :offers do |t|
      t.string :type, after: :length, limit: 128
    end
  end
end
