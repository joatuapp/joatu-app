RSpec.shared_examples "it soft deletes" do
  it "soft deletes" do
    subject.save!
    subject.destroy

    unscoped = subject.class.unscoped.find(subject.id)
    expect(unscoped).to_not be_nil
  end
end
