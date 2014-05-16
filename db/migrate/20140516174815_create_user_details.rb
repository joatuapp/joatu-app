class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.uuid :user_id
      t.string :given_name, limit: 128
      t.string :surname, limit: 128
      t.date :birth_date
      t.string :sex, limit: 32
      
      ## Current Location
      t.point :current_location, geographic: true, srid: 4326

    end

    add_index :user_details, :user_id
    add_index :user_details, :current_location, spatial: true
  end
end
