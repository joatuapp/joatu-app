require 'spec_helper'

describe Admin do

  subject { FactoryGirl.build(:admin) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  it "has a default scope for only admin users" do
    # Populate a user into the DB, to ensure that
    # Admin.all does NOT find them.
    FactoryGirl.create(:user)
    subject.save!

    admins = Admin.all
    expect(admins.size).to eq 1
    expect(admins.first.id).to eq subject.id
  end

end
