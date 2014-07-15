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

describe User do

  subject { FactoryGirl.build(:user) }

  it_behaves_like "it has a valid factory"

  it "has an accessable 'login' method" do
    expect(subject).to respond_to :login
    expect(subject).to respond_to :login=
  end

  it "belongs to a community" do
    expect(subject).to respond_to :primary_community
  end

  describe ".find_for_database_authentication" do
    it "finds by username when 'login' condition set" do
      subject.save!

      user = User.find_for_database_authentication(login: subject.username)
      expect(user.id).to eq subject.id
    end

    it "finds by email when 'login' condition set" do
      subject.save!

      user = User.find_for_database_authentication(login: subject.email)
      expect(user.id).to eq subject.id
    end
  end
end
