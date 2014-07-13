require 'spec_helper'

describe UserDetail do

  subject { FactoryGirl.build(:user_detail) }

  it_behaves_like "it has a valid factory"

  it_behaves_like "it has a lat lng accessible point", :current_location

  it "responds to profile_image" do
    expect(subject).to respond_to :profile_image
  end

  it "belongs to a user" do
    expect(subject).to respond_to :user
  end

  it "validates that a user is present" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it "belongs to a community" do
    expect(subject).to respond_to :primary_community
  end

  it_behaves_like "it soft deletes"
end
