FactoryGirl.define do
  factory :user_base do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    email_confirmation { email }

    association :detail, factory: :user_detail
  end
end
