require 'spec_helper.rb'

RSpec.describe PropayClient::Payment do
  context "management" do
    it "ProPay to ProPay success" do
      VCR.use_cassette "payment_propay_to_propay_success" do
        params = {
          "amount" => 100,
          "invNum" => "Test Invoice Number",
          "comment1" =>"Test Comment 1",
          "comment2" =>"Test Comment 2",
          "recAccntNum" => "123456"
        }
        body = PropayClient::Payment.propay_to_propay(params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59",
          "TransactionNumber" => 10
        })
      end
    end

    it "Timed Pull success" do
      VCR.use_cassette "payment_timed_pull_success" do
        params = {
          "accountNum" => 123456,
          "recAccntNum" => 987654,
          "amount" => 100,
          "transNum" => 2,
          "invNum" => "Invoice",
          "comment1" => "Test Comments",
          "comment2" => "Test Comments2"
        }
        body = PropayClient::Payment.timed_pull(params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59",
          "TransactionNumber" => 2
        })
      end
    end
  end
end
