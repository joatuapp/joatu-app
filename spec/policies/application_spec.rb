require 'policy_spec_helper'

describe ApplicationPolicy do
  subject { ApplicationPolicy }

  # Doesn't have to be a community, could be anything.
  let(:record) { FactoryGirl.create(:community) }

  include_context "policy context"

  permissions :index? do
    it "grants no access" do
      expect(subject).to_not permit(current_user, record)
    end
  end

  permissions :show? do
    it "grants no access" do
      expect(subject).to_not permit(current_user, record)
    end
  end
  
  permissions :create? do
    it "grants no access" do
      expect(subject).to_not permit(current_user, record)
    end
  end

  permissions :update? do
    it "grants no access" do
      expect(subject).to_not permit(current_user, record)
    end
  end

  permissions :destroy? do
    it "grants no access" do
      expect(subject).to_not permit(current_user, record)
    end
  end

  permissions :rails_admin? do

    let(:recognized_actions) { [:dashboard, :index, :show, :new, :edit, :destroy, :export, :history, :show_in_app] }

    it "denies access to users to all recognized actions" do
      recognized_actions.each do |action|
        expect(ApplicationPolicy.new(current_user, record).rails_admin?(action)).to be_false
      end
    end

    it "allows access to admins" do
      current_user.is_admin = true
      recognized_actions.each do |action|
        expect(ApplicationPolicy.new(current_user, record).rails_admin?(action)).to be_true
      end
    end

    it "raises error when paassed an unrecognized action" do
      expect { ApplicationPolicy.new(current_user, record).rails_admin?(:foobar) }.to raise_error Pundit::NotDefinedError
    end
  end
end
