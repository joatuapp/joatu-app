require 'policy_spec_helper'

describe OfferPolicy do
  subject { OfferPolicy }

  let(:record) { FactoryGirl.create(:offer_base) }

  permissions :index? do
    it_behaves_like "it grants anyone access"
  end

  permissions :show? do
    it_behaves_like "it grants anyone access"
  end
  
  permissions :create? do
    it_behaves_like "it grants owner and admin access"
  end

  permissions :update? do
    it_behaves_like "it grants owner and admin access"
  end

  permissions :destroy? do
    it_behaves_like "it grants owner and admin access"
  end

  context "policy scoped offers" do
    let(:count) { rand(5) + 3 }
    let(:current_user) { FactoryGirl.create(:user) }

    before :each do
      count.times do
        FactoryGirl.create(:offer_base)
      end
    end
    
    it "returns all offers" do
      expect(Pundit.policy_scope(current_user, Offer::Base).all.size).to eq count
    end
  end
end
