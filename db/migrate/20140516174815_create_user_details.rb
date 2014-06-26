class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :primary_community_id

      t.string :given_name, limit: 128
      t.string :surname, limit: 128
      t.date :birth_date
      t.string :sex, limit: 32
      
      ## Current Location
      t.point :current_location, geographic: true, srid: 4326

      t.string :postal_code, limit: 32
      t.string :neighbourhood, limit: 128
      t.string :city, limit: 128
      t.string :province, limit: 128
      t.string :country, limit: 128

      t.timestamps
      t.timestamp :deleted_at

      t.index :user_id
      t.index :primary_community_id
      t.index :current_location, spatial: true
    end
  end
end
