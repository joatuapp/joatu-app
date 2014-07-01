class CreateImages < ActiveRecord::Migration
  def change
    create_table :images, id: :uuid do |t|
      t.uuid :owner_id
      t.uuid :imageable_id
      t.string :imageable_type
      t.string :caption
      t.attachment :image
      t.string :image_fingerprint
      t.timestamps
      t.timestamp :deleted_at

      t.index :owner_id
      t.index [:imageable_id, :imageable_type]
    end
  end
end
