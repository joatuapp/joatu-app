RSpec.shared_examples "it requires authentication" do
  context "without a valid authentication token" do
    it "returns a 401 unauthorized response", document: false do
      do_request
      expect(status).to eq 401
    end
  end
end
