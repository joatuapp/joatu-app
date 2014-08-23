require 'acceptance_spec_helper'

resource 'Offers' do
  root_url = "http://#{ENV["API_SUBDOMAIN"] || 'api'}.joatu.com"

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:user) { FactoryGirl.create(:user) }
  let(:user_id) { user.id }
  let(:offer) { FactoryGirl.create(:offer_base, user: user) }
  let(:id) { offer.id }

  get "#{root_url}/users/:user_id/offers" do
    it_behaves_like "it requires authentication"

    context "when accessed with a valid authentication token" do
      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      it "returns a 200 response" do
        do_request
        expect(status).to eq 200
      end
    end
  end

  get "#{root_url}/offers/:id" do
    it_behaves_like "it requires authentication"

    context "when accessed with a valid authentication token" do
      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      it "returns the a 200 response" do
        do_request
        expect(status).to eq 200
      end

      it "returns the requested offer", document: false do
        do_request
        response_json = JSON.parse(response_body)
        expect(response_json['id']).to eq offer.id
      end
    end
  end

  post "#{root_url}/users/:user_id/offers" do
    parameter :title, "A short title for this offer."
    parameter :summary, "A sentence or two describing this offer."
    parameter :description, "A multi-line / multi-paragraph description of the offer."

    it_behaves_like "it requires authentication"

    context "when accessed with a valid authentication token" do
      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      let(:title) { Faker::Lorem.sentence(4) }
      let(:raw_post) { params.to_json }

      it "returns a 201 status" do
        do_request
        expect(status).to eq 201
      end

      it "returns a location header", document: false do
        do_request
        expect(response_headers).to have_key "Location"
      end
    end
  end

  patch "#{root_url}/offers/:id" do
    parameter :title, "A short title for this offer."
    parameter :summary, "A sentence or two describing this offer."
    parameter :description, "A multi-line / multi-paragraph description of the offer."

    it_behaves_like "it requires authentication"

    context "when accessed with a valid authentication token" do
      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      let(:title) { Faker::Lorem.sentence(4) }
      let(:raw_post) { params.to_json }

      it "returns a 204 status" do
        do_request
        expect(status).to eq 204
      end
    end
  end

  delete "#{root_url}/offers/:id" do
    it_behaves_like "it requires authentication"

    context "when accessed with a valid authentication token" do
      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      it "returns a 204 status" do
        do_request
        expect(status).to eq 204
      end
    end
  end

  get "#{root_url}/offers/types" do
    it "returns a 200 status" do
      do_request
      expect(status).to eq 200
    end
  end
end
