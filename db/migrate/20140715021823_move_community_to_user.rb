class MoveCommunityToUser < ActiveRecord::Migration
  def change
    change_table :user_details do |t|
      t.remove :primary_community_id
    end

    change_table :users do |t|
      t.uuid :primary_community_id
      t.index :primary_community_id
    end
  end
end
