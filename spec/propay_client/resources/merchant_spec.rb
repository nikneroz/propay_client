require 'spec_helper.rb'

RSpec.describe PropayClient::Merchant do
  it "create merchant success" do
    VCR.use_cassette "create_merchant_success" do
      params = build(:propay_merchant_request_data)
      body = PropayClient::Merchant.create(params)
      expect(body).to eq({
        "AccountNumber" => 123456,
        "BeneficialOwnerDataResult" => [
          {
           "FirstName" => "First1",
           "LastName" => "Last1",
           "Status" => "Validated"
          }
        ],
        "Password" => "TempPassw0rd",
        "SourceEmail" => "ProPaytest@test.com",
        "Status" => "00",
        "Tier" => "Test"
      })
    end
  end

  it "create merchant failure" do
    VCR.use_cassette "create_merchant_failure" do
      body = PropayClient::Merchant.create({})
      expect(body).to include('<title>Request Error</title>')
      expect(body).to include("The data contract type 'Propay.Contracts.MS.External.SignupRequest' cannot be deserialized because the required data member 'PersonalData' was not found.")
    end
  end
end
