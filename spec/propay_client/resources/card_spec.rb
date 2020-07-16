require 'spec_helper.rb'

RSpec.describe PropayClient::Card do
  context "management" do
    it "card create success" do
      VCR.use_cassette "card_creation_success" do
        params = {
          "ccNum" => "<card number>",
          "expDate" => "1020",
          "accountNum" => 718045866,
          "CVV2" => "022",
          "cardholderName" => "Clint Eastwood",
          "addr" => "900 Metro Center Blv",
          "zip" => "94404",
          "state" => "CA",
          "city" => "San Fransisco"
        }
        body = PropayClient::Card.create(123456, params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "79"
        })
      end
    end
  end
end
