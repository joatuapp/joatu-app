# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  username               :string(64)       default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  authentication_token   :string(255)
#  is_admin               :boolean          default(FALSE), not null
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  deleted_at             :datetime
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class Image < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :imageable, polymorphic: true
  belongs_to :owner, class: User, foreign_key: :owner_id,inverse_of: :owned_images

  validates :owner, presence: true

  has_attached_file(:image, 
                    styles: {tiny: "32x32>", thumbnail: "170x170>"},
                    convert_options: {tiny: "-quality 75", thumbnail: "-quality 85"},
                    preserve_files: true,
                    default_url: "/assets/:style/default_profile_pic.png",
                   )

  validates_attachment :image, 
    presence: true,
    content_type: { content_type: /\Aimage\/.*\Z/ },
    size: { in: 0..10.megabytes }
end
