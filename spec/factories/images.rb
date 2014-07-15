# == Schema Information
#
# Table name: images
#
#  id                 :uuid             not null, primary key
#  owner_id           :uuid
#  imageable_id       :uuid
#  imageable_type     :string(255)
#  caption            :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  image_fingerprint  :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  deleted_at         :datetime
#
# Indexes
#
#  index_images_on_imageable_id_and_imageable_type  (imageable_id,imageable_type)
#  index_images_on_owner_id                         (owner_id)
#

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :image do
    association :owner, factory: :user
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.png'), 'image/png') }
  end
end
