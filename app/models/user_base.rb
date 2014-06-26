# This is the base class of the user and admin models. 
class UserBase < ActiveRecord::Base
  acts_as_paranoid

  self.table_name = :users

  # Relations
  has_one :detail, class: UserDetail, foreign_key: :user_id
  accepts_nested_attributes_for :detail

  has_many :offers
  has_many :offer_categories, through: :offers

  # Validations:
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, confirmation: true
  validates :email_confirmation, presence: true, on: :create
end
