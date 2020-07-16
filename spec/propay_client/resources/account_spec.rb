require 'spec_helper.rb'

RSpec.describe PropayClient::Merchant do
  context "management" do
    it "account renewal success" do
      VCR.use_cassette "account_renewal_success" do
        params = {
          "accountNum" => 123456,
          "CVV2" => 999,
          "tier"  => "194e4047-69b5-4e7c-b",
          "ccNum" => "4111111111111111",
          "expDate" =>"1221",
          "zip" => "12345"
        }
        body = PropayClient::Account.renewal(params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59",
          "Tier" => "194e4047-69b5-4e7c-b"
        })
      end
    end
  end
end
