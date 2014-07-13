include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :image do
    association :owner, factory: :user
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png') }
  end
end
