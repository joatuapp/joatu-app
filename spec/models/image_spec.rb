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
