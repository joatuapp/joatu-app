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

# This is the base class of the user and admin models. 
class UserBase < ActiveRecord::Base
  acts_as_paranoid

  self.table_name = :users

  # Relations
  has_one :detail, class: UserDetail, foreign_key: :user_id
  accepts_nested_attributes_for :detail

  has_many :offers, foreign_key: :user_id
  has_many :offer_categories, through: :offers

  # Validations:
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, confirmation: true
  validates :email_confirmation, presence: true, on: :create
end
