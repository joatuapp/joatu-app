require 'policy_spec_helper'

describe UserPolicy do
  subject { UserPolicy }

  permissions :index? do
    it_behaves_like "it grants anyone access"
  end

  permissions :show? do
    it_behaves_like "it grants anyone access"
  end
  
  permissions :create? do
    it_behaves_like "it grants anyone access"
  end

  permissions :update? do
    it_behaves_like "it grants owner and admin access"
  end

  permissions :destroy? do
    it_behaves_like "it grants owner and admin access"
  end

  context "policy scoped users" do
    let(:count) { rand(5) + 3 }
    let(:current_user) { FactoryGirl.create(:user) }

    before :each do
      count.times do
        FactoryGirl.create(:user)
      end
    end
    
    it "returns all users" do
      # NOTE: Should match count + 1 because we're also creating a user to be
      # the current_user, and that user should be returned as well.
      expect(Pundit.policy_scope(current_user, User).all.size).to eq (count + 1)
    end
  end
end
