require 'spec_helper'

describe UserBase do

  subject { FactoryGirl.build(:user_base) }

  it_behaves_like "it has a valid factory"

  it "has a detail object" do
    expect(subject).to respond_to :detail
  end

  it "has many offers" do
    expect(subject).to respond_to :offers
    expect(subject.offers).to respond_to :each
  end

  it "has many owned_images" do
    expect(subject).to respond_to :owned_images
    expect(subject.owned_images).to respond_to :each
  end

  it "has many images" do
    expect(subject).to respond_to :images
    expect(subject.images).to respond_to :each
  end

  it "is valid from the factory" do
    expect(subject).to be_valid
  end

  it "validates username presence" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "validates username uniqueness" do
    username = "foobar"
    FactoryGirl.create(:user_base, username: username)

    subject.username = username
    expect(subject).to_not be_valid
  end

  it "validates email presence" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "validates email confirmation on create" do
    subject.email_confirmation = nil
    expect(subject).to_not be_valid
  end

  it "does not validate email confirmation on update" do
    subject.save!
    subject.email_confirmation = nil
    expect(subject).to be_valid
  end

  it_behaves_like "it soft deletes"
end
