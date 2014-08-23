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

require 'spec_helper'

describe Image do

  subject { FactoryGirl.build(:image) }

  it_behaves_like "it has a valid factory"

  it "belongs to imageable" do
    expect(subject).to respond_to :imageable
  end

  it "belongs to an owner" do
    expect(subject).to respond_to :owner
  end

  it "validates an owner is present" do
    subject.owner = nil
    expect(subject).to_not be_valid
  end

  it "has an attached image" do
    expect(subject).to have_attached_file(:image)
  end

  it "validates the image presence" do
    subject.image = nil
    expect(subject).to_not be_valid
  end

  it "validates the content type" do
    expect(subject).to validate_attachment_content_type(:image).allowing('image/png', 'image/gif', 'image/jpg').rejecting('text/json', 'text/html', 'application/javascript')
  end

  it "validates image size" do
    expect(subject).to validate_attachment_size(:image).less_than(10.megabytes)
  end

  it_behaves_like "it soft deletes"
end
