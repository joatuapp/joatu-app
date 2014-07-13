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

# This is the base class of the user and admin models. 
class UserBase < ActiveRecord::Base
  acts_as_paranoid
  acts_as_taggable_on :accepted_currencies


  self.table_name = :users

  # Relations
  has_one :detail, class: UserDetail, foreign_key: :user_id, inverse_of: :user
  accepts_nested_attributes_for :detail

  has_many :offers, class: Offer::Base, foreign_key: :user_id, inverse_of: :user

  has_many :owned_images, class: Image, foreign_key: :owner_id
  has_many :images, as: :imageable

  # Validations:
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, confirmation: true
  validates :email_confirmation, presence: true, on: :create
end
