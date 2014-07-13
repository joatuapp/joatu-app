require 'policy_spec_helper'

describe CommunityPolicy do
  subject { CommunityPolicy }

  let(:record) { FactoryGirl.create(:community) }

  permissions :index? do
    it_behaves_like "it grants anyone access"
  end

  permissions :show? do
    it_behaves_like "it grants anyone access"
  end
  
  permissions :create? do
    it_behaves_like "it grants admins access"
  end

  permissions :update? do
    it_behaves_like "it grants admins access"
  end

  permissions :destroy? do
    it_behaves_like "it grants admins access"
  end

  context "policy scoped communities" do
    let(:count) { rand(5) + 3 }
    let(:current_user) { FactoryGirl.create(:user) }

    before :each do
      Community.delete_all
      count.times do
        FactoryGirl.create(:community)
      end
    end
    
    it "returns all communities" do
      expect(Pundit.policy_scope(current_user, Community).all.size).to eq count
    end
  end
end
