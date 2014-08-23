# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    email_confirmation { email }
    password { Faker::Internet.password(10) }

    association :detail, factory: :user_detail
  end
end
