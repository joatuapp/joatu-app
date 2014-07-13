FactoryGirl.define do
  factory :offer_base, class: Offer::Base do
    association :user
  end
end
