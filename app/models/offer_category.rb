class OfferCategory < ActiveRecord::Base
  acts_as_paranoid

  has_many :offers
  has_many :users, through: :offers
end
