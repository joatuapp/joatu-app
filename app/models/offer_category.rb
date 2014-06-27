# == Schema Information
#
# Table name: offer_categories
#
#  id         :uuid             not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  deleted_at :datetime
#

class OfferCategory < ActiveRecord::Base
  acts_as_paranoid

  has_many :offers
  has_many :users, through: :offers
end
