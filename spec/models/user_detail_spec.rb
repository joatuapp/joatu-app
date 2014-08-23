# == Schema Information
#
# Table name: user_details
#
#  id               :uuid             not null, primary key
#  user_id          :uuid
#  given_name       :string(128)
#  surname          :string(128)
#  birth_date       :date
#  sex              :string(32)
#  current_location :spatial          point, 4326
#  postal_code      :string(32)
#  neighbourhood    :string(128)
#  city             :string(128)
#  province         :string(128)
#  country          :string(128)
#  created_at       :datetime
#  updated_at       :datetime
#  deleted_at       :datetime
#  about_me         :text
#  profile_image_id :uuid
#
# Indexes
#
#  index_user_details_on_current_location  (current_location)
#  index_user_details_on_user_id           (user_id) UNIQUE
#

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

  it_behaves_like "it soft deletes"
end
