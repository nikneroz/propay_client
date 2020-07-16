require 'spec_helper.rb'

RSpec.describe PropayClient::Merchant do
  context "create" do
    it "merchant success" do
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

    it "merchant failure" do
      VCR.use_cassette "create_merchant_failure" do
        body = PropayClient::Merchant.create({})
        expect(body).to include('<title>Request Error</title>')
        expect(body).to include("The data contract type 'Propay.Contracts.MS.External.SignupRequest' cannot be deserialized because the required data member 'PersonalData' was not found.")
      end
    end
  end

  context "edit" do
    it "edit merchant contact info success" do
      VCR.use_cassette "edit_merchant_contact_info_success" do
        params = {
          "AccountNumber" => 123456,
          "PersonalData" => {
            "FirstName" => "Bob",
            "MiddleInitial" => "N",
            "LastName" => "Takanawa",
            "SourceEmail" => "200514042252msedit@propay.com",
            "PhoneInformation" => { 
              "DayPhone" => 8015555555,
              "EveningPhone" => 8015555555}
          },
          "ExternalId" => "200514042252"
        }
        body = PropayClient::Merchant.edit_merchant_contact_info(123456, params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59"
        })
      end
    end

    it "edit merchant address success" do
      VCR.use_cassette "edit_merchant_address_success" do
        params = {
          "AccountNumber" => 123456,
          "Address" => {
            "ApartmentNumber" => "K",
            "Address1" => "123 New Street",
            "Address2" => "Some address2",
            "City" => "LA",
            "State" => "CA",
            "Country" => "USA",
            "Zip" => "90210"
          },
          "MailAddress": {
            "ApartmentNumber": nil,
            "Address1" => "PO Box 111",
            "Address2" => "Some street",
            "City" => "LA",
            "State" => "CA",
            "Country" => "USA",
            "Zip" => "90210"
          }
        }
        body = PropayClient::Merchant.edit_merchant_address(123456, params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59"
        })
      end
    end
  end
end
