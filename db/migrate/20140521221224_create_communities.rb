class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities, id: :uuid do |t|
      t.string :name, limit: 128
      t.point :location, geographic: true, srid: 4326
      t.timestamps
      t.timestamp :deleted_at

      t.index :location, spatial: true
    end
  end
end
