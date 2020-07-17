require 'spec_helper.rb'

RSpec.describe PropayClient::API do
  it "Generates API token for ProPay Authorization" do
    VCR.use_cassette "payment_propay_to_propay_success" do
      token = PropayClient::API.generate_token(ENV['CERT_STR'], ['TERM_ID'])
      expect(token).to eq(ENV['PROPAY_API_KEY'])
    end
  end
end
