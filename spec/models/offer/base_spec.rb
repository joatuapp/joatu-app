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
end
