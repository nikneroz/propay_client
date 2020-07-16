require 'spec_helper.rb'

RSpec.describe PropayClient::Document do
  context "management" do
    it "document upload success" do
      VCR.use_cassette "document_upload_success" do
        params = {
          "accountNum" => 123456,
          "DocumentName" => "Chargeback 1234",
          "TransactionReference" => "100",
          "Document" => "BASE64 STRING LESS THAN 5MB",
          "DocType" => "jpg",
          "Identification" => "Null"
        }
        body = PropayClient::Document.upload(params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59",
        })
      end
    end
  end
end
