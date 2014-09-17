require 'acceptance_spec_helper'

resource 'Registrations' do
  root_url = "http://#{ENV.fetch("API_SUBDOMAIN")}.joatu.com"

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  post "#{root_url}/users" do
    parameter :username, "Username of the new user.", required: true
    parameter :email, "Email address of the new user.", required: true
    parameter :email_confirmation, "The same email address again, to confirm.", required: true
    parameter :password, "The user's desired password.", required: true

    # TODO Add other, optional parameters here to flesh out the API documentation.

    context "with valid data" do

      let(:username) { Faker::Internet.user_name }
      let(:email) { Faker::Internet.email }
      let(:email_confirmation) { email }
      let(:password) { Faker::Internet.password }

      let(:raw_post) { params.to_json }
      it "returns a 201 status" do
        do_request
        expect(status).to eq 201
      end

      it "returns a location header pointing to the new resource" do
        do_request
        expect(response_headers).to have_key "Location"
        expect(response_headers["Location"]).to match(/\/users\/[-a-z0-9]+/)
      end
    end

    context "with invalid data" do
      it "returns a 422 'unacceptable' stauts" do
        do_request
        expect(status).to eq 422
      end
    end
  end
end
