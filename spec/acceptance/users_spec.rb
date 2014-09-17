require 'acceptance_spec_helper'

resource 'Users' do
  root_url = "http://#{ENV.fetch("API_SUBDOMAIN")}.joatu.com"

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:user) { FactoryGirl.create(:user_with_detail) }
  let(:id) { user.id }

  get "#{root_url}/users/:id" do
    it_behaves_like "it requires authentication"

    context "when accessed with a valid authentication token" do
      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      it "returns the a 200 response" do
        do_request
        expect(status).to eq 200
      end

      it "returns the requested user", document: false do
        do_request
        response_json = JSON.parse(response_body)
        expect(response_json['id']).to eq user.id
      end
    end
  end

  get "#{root_url}/users/me" do
    it_behaves_like "it requires authentication"

    context "when accessed with a valid authentication token" do
      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      it "returns a 200 response" do
        do_request
        expect(status).to eq 200
      end

      it "returns the requested user", document: false do
        do_request
        response_json = JSON.parse(response_body)
        expect(response_json['id']).to eq user.id
      end
    end
  end

  patch "#{root_url}/users/:id" do
    parameter :username, "Username of the new user.", required: true
    parameter :email, "Email address of the new user.", required: true
    parameter :email_confirmation, "The same email address again, to confirm.", required: true
    parameter :password, "The user's desired password.", required: true

    it_behaves_like "it requires authentication"

    # TODO Add other, optional parameters here to flesh out the API documentation.
    #
    context "when logged in" do
      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      context "with valid data" do
        let(:email) { Faker::Internet.email }

        let(:raw_post) { params.to_json }
        it "returns a 200 status" do
          do_request
          expect(status).to eq 204
        end
      end

      context "with invalid data" do
        let(:email) { "foo" }

        let(:raw_post) { params.to_json }
        it "returns a 422 status" do
          do_request
          expect(status).to eq 422
        end
      end
    end
  end
end
