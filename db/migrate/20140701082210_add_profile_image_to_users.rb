class AddProfileImageToUsers < ActiveRecord::Migration
  def change
    change_table :user_details do |t|
      t.uuid :profile_image_id, after: :primary_community_id
    end
  end
end
