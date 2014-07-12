require 'spec_helper'

describe User do

  subject { FactoryGirl.build(:user) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  it "has an accessable 'login' method" do
    expect(subject).to respond_to :login
    expect(subject).to respond_to :login=
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
