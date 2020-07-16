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
        body = PropayClient::Merchant.edit_contact_info(123456, params)
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
        body = PropayClient::Merchant.edit_address(123456, params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59"
        })
      end
    end

    it "edit merchant renewal payment method success" do
      VCR.use_cassette "edit_merchant_renewal_payment_method_success" do
        params = {
          "AccountNumber" => 123456,
          "CreditCardData" => nil,
          "PaymentBank" => {
            "AccountNumber" => "7654321",
            "RoutingNumber" => "324079555",
            "AccountType" => "Savings"
          }
        }
        body = PropayClient::Merchant.edit_renewal_payment_method(123456, params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59"
        })
      end
    end

    it "edit merchant business info success" do
      VCR.use_cassette "edit_merchant_business_info_success" do
        params = {
          "AccountNumber" => 123456,
          "AuthorizedSignerFirstName" => "TestFirstName",
          "AuthorizedSignerLastName" => "TestLastName",
          "AuthorizedSignerTitle" => "TestTitle",
          "BusinessData" => {
            "BusinessLegalName" => "Testlegalname",
            "DoingBusinessAs" => "TestDBA",
            "EIN" => "584384656",
            "WebsiteURL" => "www.test.com",
            "BusinessDescription" => "Test description",
            "MonthlyBankCardVolume" => 9000,
            "HighestTicket" => 1000
          },
          "BusinessAddress" => {
            "ApartmentNumber" => nil,
            "Address1" => "AddressLine1",
            "Address2" => "AddressLine2",
            "City" => "TestCity",
            "State" => "CA",
            "Country": nil,
            "Zip" => "13245"
          }
        }
        body = PropayClient::Merchant.edit_business_info(123456, params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59"
        })
      end
    end

    it "edit merchant bank account success" do
      VCR.use_cassette "edit_merchant_bank_account_success" do
        params = {
          "AccountNumber" => 123456,
          "IsSecondaryBankAccount" => false,
          "BankAccount" => {
            "AccountCountryCode" => "USA",
            "BankAccountNumber" => 111111111,
            "RoutingNumber" => "091000019",
            "AccountOwnershipType" => "Business",
            "BankName" => "Bank Name",
            "AccountType" => "Checking"
          }
        }
        body = PropayClient::Merchant.edit_bank_account(123456, params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59"
        })
      end
    end

    it "edit merchant gross settle payment info success" do
      VCR.use_cassette "edit_merchant_gross_settle_payment_info_success" do
        params = {
          "AccountNumber" => 123456,
          "GrossBillingInformation" => {
            "GrossSettleBankAccount" => nil,
            "GrossSettleAddress" => {
              "Address1" =>"123 Main Stree",
              "City" =>"LA",
              "State" =>"CA",
              "Country" =>"USA",
              "Zip" =>"90210"
            },
            "GrossSettleCardData" =>{
              "NameOnCard" =>"Bo Diddley",
              "CreditCardNumber" =>"<credit card number>",
              "ExpirationDate" =>"0522"
            },
            "GrossSettlePropayAccount" => nil
          }
        }
        body = PropayClient::Merchant.edit_gross_settle_payment_info(123456, params)
        expect(body).to eq({
          "AccountNumber" => 123456,
          "Status" => "59"
        })
      end
    end
  end
end
