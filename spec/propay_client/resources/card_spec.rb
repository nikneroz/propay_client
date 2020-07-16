require 'spec_helper.rb'

RSpec.describe PropayClient::Card do
  context "management" do
    it "creates or updates card success" do
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

    it "pushes funds to flash funds card success" do
      VCR.use_cassette "pushes_funds_to_flash_funds_card_success" do
        params = {
          "accountNum" => 123456,
          "amount" => "1000"
        }
        body = PropayClient::Card.push_funds_to_flash_funds_card(123456, params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "79"
        })
      end
    end
  end
end
