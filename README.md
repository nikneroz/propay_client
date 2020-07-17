# PropayClient

[![Gem Version](https://img.shields.io/gem/v/propay_client)](https://github.com/nikneroz/propay_client)
[![Downloads](https://img.shields.io/gem/dt/propay_client)](https://github.com/nikneroz/propay_client)
[![Build](https://img.shields.io/travis/com/nikneroz/propay_client)](https://travis-ci.com/github/nikneroz/propay_client)
[![CodeCov](https://img.shields.io/codecov/c/github/nikneroz/propay_client)](https://codecov.io/gh/nikneroz/propay_client)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/propay_client`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'propay_client', '~> 0.2.0'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install propay_client

## Usage

```ruby
# config/initializers/propay_client.rb

require 'propay_client'

PropayClient.configure do |config|
  config.api_key = ENV['PROPAY_API_KEY']
  config.endpoint = ENV['ENDPOINT']
end
```

### Merchant
[Documentation](https://www.propay.com/en-US/Documents/API-Docs/ProPay-API-Manual-REST)

#### Creation
```ruby
  # Account Creation
  PropayClient::Merchant.create(params)

  # Get current ProPay Account Balance
  account_number = 123456
  body = PropayClient::Merchant.balance(account_number)

  # Account Renewal
  params = {
    "accountNum" => 123456,
    "CVV2" => 999,
    "tier"  => "194e4047-69b5-4e7c-b",
    "ccNum" => "4111111111111111",
    "expDate" =>"1221",
    "zip" => "12345"
  }
  PropayClient::Account.renewal(params)

  # Document Upload
  params = {
    "accountNum" => 123456,
    "DocumentName" => "Chargeback 1234",
    "TransactionReference" => "100",
    "Document" => "BASE64 STRING LESS THAN 5MB",
    "DocType" => "jpg",
    "Identification" => "Null"
  }
  PropayClient::Document.upload(params)

  # Flash Funds - Add or Change Card Assigned to a ProPay Account
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
  PropayClient::Card.create(123456, params)
  PropayClient::Card.update(123456, params)

  # Flash Funds –Push Funds to On-File Card
  params = {
    "accountNum" => 123456,
    "amount" => "1000"
  }
  PropayClient::Card.push_funds_to_flash_funds_card(123456, params)

  # ProPay Account Payment Disbursement
  params = {
    "amount": 100,
    "invNum": "Test Invoice Number",
    "comment1":"Test Comment 1",
    "comment2":"Test Comment 2",
    "recAccntNum": "123456"
  }
  body = PropayClient::Payment.propay_to_propay(params)

  # SplitFunds froma ProPay Transaction(Timed Pull)
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
```

#### Editing
```ruby
  # Contact Info
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
  PropayClient::Merchant.edit_contact_info(123456, params)

  # Address
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
  PropayClient::Merchant.edit_address(123456, params)

  # Renewal Payment Method
  params = {
    "AccountNumber" => 123456,
    "CreditCardData" => nil,
    "PaymentBank" => {
      "AccountNumber" => "7654321",
      "RoutingNumber" => "324079555",
      "AccountType" => "Savings"
    }
  }
  PropayClient::Merchant.edit_renewal_payment_method(123456, params)

  # Business Info
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
  PropayClient::Merchant.edit_business_info(123456, params)

  # Bank Account
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
  PropayClient::Merchant.edit_bank_account(123456, params)

  # Gross Settle Payment Info
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
  PropayClient::Merchant.edit_gross_settle_payment_info(123456, params)

  # Services
  params = {
    "AccountNumber" => 123456,
    "CcProcessing" => true,
    "ACHOut" => true,
    "ACHIn" => true,
    "ProPayOut" => true,
    "ProPayIn" => true,
    "SoftLimitEnabled" => "y",
    "AchPaymentSoftLimitEnabled" => "y",
    "CreditCardMonthLimit" => 0,
    "CreditCardTransactionLimit" => 0,
    "SoftLimitAchOffPercent" => 0,
    "AchPaymentAchOffPercent" => 0
  }
  PropayClient::Merchant.edit_services(123456, params)

  # Status
  params = {
    "AccountNumber" => 123456,
    "MerchantStatus" => "Canceled"
  }
  PropayClient::Merchant.edit_status(123456, params)

  # Credit Limit
  params = {
    "AccountNumber" => 123456,
    "CreditLimit" => 1000
  }
  PropayClient::Merchant.edit_credit_limit(123456, params)
```

### API Authorization.
You will need to get personal certificate. Convert this to token and use for API requests.
[Documentation](https://www.propay.com/en-US/Documents/API-Docs/ProtectPay-API-Manual-REST "ProtectPay-API-Manual-REST")


```
The REST interface uses Basic HTTP Authentication for API requests, with the CertStr as the username and the TermId as the password. This must be added to the HTTP header as the value of the ‘Authorization’ field. Creating the Authorization Header value requires the following steps:
1. Combine the CertStr, a Colon, and the termId (MyCertStr:MyTermId). If a termId has not been provided only use the CertStr without a colon
(MyCertStr).
2. Convert the Result of Step 1 to an ASCII Byte Array
3. Base 64 Encode the Result of Step 2
4. Prepend “Basic “ to the Result of Step 3
5. Add ‘Authorization’ as an HTTP header and set its value to the result of Step 4
```

### API Authentication
[Documentation](https://www.propay.com/en-US/Documents/API-Docs/ProtectPay-API-Manual-REST "ProtectPay-API-Manual-REST")

```
The REST interface uses Basic HTTP Authentication to authenticate API requests using the BillerId as the username and the Authentication Token as the password. This must be added to the HTTP header as the value of the ‘Authorization’ field.
Creating the Authorization Header value requires the following steps:
1. Combine the BillerID, a Colon, and the AuthToken (MyBillerId:MyAuthToken)
2. Convert the Result of Step 1 to an ASCII Byte Array
3. Base 64 Encode the Result of Step 2
4. Prepend “Basic “ to the Result of Step 3
5. Add ‘Authorization’ as an HTTP header and set its value to the result of Step 4
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/propay_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/propay_client/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PropayClient project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/propay_client/blob/master/CODE_OF_CONDUCT.md).
