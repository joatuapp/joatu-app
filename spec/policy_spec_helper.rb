require 'spec_helper'
require 'pundit/rspec'

RSpec.shared_context "policy context" do
  let(:user) { FactoryGirl.create(:user) }
  let(:current_user) { FactoryGirl.create(:user) }
end

RSpec.shared_examples "it grants owner and admin access" do
  include_context "policy context"

  it "denies access to other users" do
    expect(subject).to_not permit(current_user, user)
  end

  it "allows access to the owning user" do
    expect(subject).to permit(current_user, current_user)
  end

  it "allows access to admins" do
    current_user.is_admin = true
    expect(subject).to permit(current_user, user)
  end
end

RSpec.shared_examples "it grants anyone access" do
  include_context "policy context"

  it "allows access to other users" do
    expect(subject).to permit(current_user, user)
  end

  it "allows access to admins" do
    current_user.is_admin = true
    expect(subject).to permit(current_user, user)
  end
end
