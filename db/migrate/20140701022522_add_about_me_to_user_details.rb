class AddAboutMeToUserDetails < ActiveRecord::Migration
  def change
    change_table :user_details do |t|
      t.text :about_me, after: :surname
    end
  end
end
