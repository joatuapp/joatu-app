require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Sessions" do
  root_url = "http://#{ENV["API_SUBDOMAIN"] || 'api'}.joatu.com"

  header "Accept", "application/json"

  let(:user_password) { "foobarbash" }
  let(:user) { FactoryGirl.create(:user, password: user_password, password_confirmation: user_password) }

  post "#{root_url}/users/sign_in" do
    parameter :login, "The username or email of the user to log in.", required: true
    parameter :password, "The password of the user to log in.", required: true

    context "with no credentials" do
      it "returns a 401 status", document: false do
        do_request
        expect(status).to eq 401
      end
    end

    context "with invalid credentials" do
      let(:login) { "foo" }
      let(:password) { "bar" }

      it "returns a 401 status", document: false do
        do_request
        expect(status).to eq 401
      end
    end

    context "with valid username and password" do
      let(:login) { user.username }
      let(:password) { user_password }

      it "returns a 201 status" do
        do_request
        expect(status).to eq 201
      end
    end

    context "with valid email and password" do
      let(:login) { user.email }
      let(:password) { user_password }

      it "returns a 201 status" do
        do_request
        expect(status).to eq 201
      end
    end
  end

  delete "#{root_url}/users/sign_out" do
     
    context "with a valid authorization header" do

      before :each do
        header "Authorization", "Basic #{Base64.encode64(user.authentication_token)}"
      end

      it "returns a 204 status" do
        do_request
        expect(status).to eq 204
      end

      it "resets the user's authentication token", document: false do
        auth_token = user.authentication_token
        do_request
        user.reload
        expect(user.authentication_token).to_not eq auth_token
      end
    end

    context "without a valid authorizaiton header" do
      it "returns a 401 status" do
        do_request
        expect(status).to eq 401
      end
    end
  end
end
