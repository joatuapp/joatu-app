require 'spec_helper'

describe UserDetail do

  subject { FactoryGirl.build(:user_detail) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  it_behaves_like "it has a lat lng accessible point", :current_location
end
