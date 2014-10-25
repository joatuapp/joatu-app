require 'acceptance_spec_helper'

resource 'Communities' do
  if ENV.key? "API_SUBDOMAIN"
    root_url = "http://#{ENV.fetch("API_SUBDOMAIN")}.joatu.com"
  else
    root_url = "http://joatu.com"
  end

  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "#{root_url}/communities" do
    parameter :latitude, "If given along with longitude (and optionally distance) specifies an area in which to look for communities."
    parameter :longtiude, "If given along with latitude (and optionally distance) specifies an area in which to look for communities."
    parameter :distance, "The radius of the circle in which to look for communities, in meters. Defaults to 5000 (5km)."
    it "returns a 200 response" do
      do_request
      expect(status).to eq 200
    end
  end
end
