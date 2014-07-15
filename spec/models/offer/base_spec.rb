# == Schema Information
#
# Table name: offers
#
#  id            :uuid             not null, primary key
#  user_id       :uuid
#  title         :string(128)
#  summary       :string(255)
#  description   :text
#  location      :spatial          point, 4326
#  address1      :string(128)
#  address2      :string(128)
#  postal_code   :string(32)
#  neighbourhood :string(128)
#  city          :string(128)
#  province      :string(128)
#  country       :string(128)
#  timeframe     :string(128)
#  length        :integer
#  created_at    :datetime
#  updated_at    :datetime
#  deleted_at    :datetime
#  type          :string(128)
#
# Indexes
#
#  index_offers_on_user_id  (user_id)
#

require 'spec_helper'

describe Offer::Base do

  subject { FactoryGirl.build(:offer_base) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  it "soft deletes" do
    subject.save!
    subject.destroy

    offer = Offer::Base.unscoped.find(subject.id)
    expect(offer).to_not be_nil
  end

  it "belongs to a user" do
    expect(subject).to respond_to :user
  end

  it "validates that a user is present" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it_behaves_like "it has a lat lng accessible point", :location
end
