require 'spec_helper'

describe Community do

  subject { FactoryGirl.build(:community) }

  it_behaves_like "it has a valid factory"
  it_behaves_like "it soft deletes"
  it_behaves_like "it has a lat lng accessible point", :location

  describe ".near" do
    context "when latitude not given" do
      let(:lat) { nil }
      let(:lng) { 10 }

      it "returns self" do
        klass = subject.class
        expect(klass.near(lat, lng)).to eq klass
      end
    end

    context "when longitude not given" do
      let(:lat) { 10 }
      let(:lng) { nil }

      it "returns self" do
        klass = subject.class
        expect(klass.near(lat, lng)).to eq klass
      end
    end

    context "when latitude and longitude present" do
      let(:lat) { 10 }
      let(:lng) { 10 }

      near = FactoryGirl.create(:community, location: "POINT(10 10)")
      FactoryGirl.create(:community, location: "POINT(80, 80)")

      it "queries for nearby communities" do
        result = subject.class.near(lat, lng)
        expect(result).to be_kind_of ActiveRecord::Relation
        matches = result.select {|r| r == near }
        expect(matches).to be_true
      end
    end
  end
end
