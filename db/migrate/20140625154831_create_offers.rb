class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offer_categories, id: :uuid do |t|
      t.string :name, null: false
      t.timestamps
      t.timestamp :deleted_at
    end

    create_table :offers, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :offer_category_id

      t.string :title, limit: 128
      t.string :summary
      t.text :description

      t.point :location, geographic: true, srid: 4326

      t.string :address1, limit: 128
      t.string :address2, limit: 128
      t.string :postal_code, limit: 32
      t.string :neighbourhood, limit: 128
      t.string :city, limit: 128
      t.string :province, limit: 128
      t.string :country, limit: 128

      t.string :timeframe, limit: 128
      t.integer :length # Will store # minutes for max flexibility.

      t.timestamps
      t.timestamp :deleted_at

      t.index :user_id
      t.index :offer_category_id
    end
  end
end
