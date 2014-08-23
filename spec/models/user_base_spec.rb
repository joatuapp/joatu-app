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
#  primary_community_id   :uuid
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_primary_community_id  (primary_community_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

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
