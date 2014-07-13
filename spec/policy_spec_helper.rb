require 'spec_helper'
require 'pundit/rspec'

RSpec.shared_context "policy context" do
  let(:current_user) { FactoryGirl.create(:user) }
end

RSpec.shared_examples "it grants owner and admin access" do |owner_id_field = :user_id|
  include_context "policy context"

  it "denies access to other users" do
    expect(subject).to_not permit(current_user, record)
  end

  it "allows access to the owning user" do
    if record.is_a? User
      record.id = current_user.id
    else
      current_user.id = record.send(owner_id_field) 
    end
    expect(subject).to permit(current_user, record)
  end

  it "allows access to admins" do
    current_user.is_admin = true
    expect(subject).to permit(current_user, record)
  end
end

RSpec.shared_examples "it grants anyone access" do
  include_context "policy context"

  it "allows access to other users" do
    expect(subject).to permit(current_user, record)
  end

  it "allows access to admins" do
    current_user.is_admin = true
    expect(subject).to permit(current_user, record)
  end
end

RSpec.shared_examples "it grants admins access" do
  include_context "policy context"

  it "denies access to users" do
    expect(subject).to_not permit(current_user, record)
  end

  it "allows access to admins" do
    current_user.is_admin = true
    expect(subject).to permit(current_user, record)
  end
end
