require 'policy_spec_helper'

describe ImagePolicy do
  subject { ImagePolicy }

  let(:record) { FactoryGirl.create(:image) }

  permissions :index? do
    it_behaves_like "it grants anyone access"
  end

  permissions :show? do
    it_behaves_like "it grants anyone access"
  end
  
  permissions :create? do
    it_behaves_like "it grants owner and admin access", :owner_id
  end

  permissions :update? do
    it_behaves_like "it grants owner and admin access", :owner_id
  end

  permissions :destroy? do
    it_behaves_like "it grants owner and admin access", :owner_id
  end

  context "policy scoped communities" do
    let(:count) { rand(5) + 3 }
    let(:current_user) { FactoryGirl.create(:user) }

    before :each do
      count.times do
        FactoryGirl.create(:image)
      end
    end
    
    it "returns all images" do
      expect(Pundit.policy_scope(current_user, Image).all.size).to eq count
    end
  end
end
