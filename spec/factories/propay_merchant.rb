FactoryBot.define do
  factory :personal_data, class: Hash do
    defaults = {
      "FirstName" => "First",
      "MiddleInitial" => "X",
      "LastName" => "Last",
      "DateOfBirth" => "01-01-1981",
      "SocialSecurityNumber" => "123456789",
      "SourceEmail" => "ProPaytest@test.com",
      "NotificationEmail" => "Partner@Partner.com",
      "PhoneInformation" => {
        "DayPhone" => "8888888888",
        "EveningPhone" => "8888888888"
      }
    }
    initialize_with{ defaults.merge(attributes) }
  end

  factory :signup_account_data, class: Hash do
    defaults = {
      "CurrencyCode" => "USD",
      "Tier" => "Test"
    }
    initialize_with{ defaults.merge(attributes) }
  end

  factory :business_data, class: Hash do
    defaults = {
      "BusinessLegalName" => "Merchantile Parent, Inc.",
      "DoingBusinessAs" => "Merchantile ABC",
      "EIN" => "121232343",
      "MerchantCategoryCode" => "5999",
      "WebsiteURL" => "http://Propay.com",
      "BusinessDescription" => "Accounting Services",
      "MonthlyBankCardVolume" => 10000,
      "AverageTicket" => 100,
      "HighestTicket" => 250
    }
    initialize_with{ defaults.merge(attributes) }
  end

  factory :address, class: Hash do
    defaults = {
      "ApartmentNumber" => "1",
      "Address1" => "3400 N Ashton Blvd",
      "Address2" => "Suite 200",
      "City" => "Lehi",
      "State" => "UT",
      "Country" => "USA",
      "Zip" => "84043"
    }
    initialize_with{ defaults.merge(attributes) }
  end

  factory :business_address, class: Hash do
    defaults = {
      "ApartmentNumber" => "200",
      "Address1" => "RR 123445",
      "Address2" => "SW",
      "City" => "Tooele",
      "State" => "UT",
      "Country" => "USA",
      "Zip" => "84074"
    }
    initialize_with{ defaults.merge(attributes) }
  end

  factory :bank_account, class: Hash do
    defaults = {
      "AccountCountryCode" => "USA",
      "BankAccountNumber" => "123456789",
      "RoutingNumber" => "011306829",
      "AccountOwnershipType" => "Business",
      "BankName" => "MERCHANTILE BANK UT",
      "AccountType" => "Checking",
      "AccountName" => nil,
      "Description" => nil
    }
    initialize_with{ defaults.merge(attributes) }
  end

  factory :beneficial_owner_data, class: Hash do
    defaults = {
      "OwnerCount" => "1",
      "Owners" => [
        {
          "FirstName" => "First1",
          "LastName" => "Last1",
          "SSN" => "123456789",
          "DateOfBirth" => "01-01-1981",
          "Email" => "test1@qamail.com",
          "Address" => "Address",
          "City" => "Lehi",
          "State" => "UT",
          "Zip" => "84010",
          "Country" => "USA",
          "Title" => "CEO",
          "Percentage" => "100"
        }
      ]
    }
    initialize_with{ defaults.merge(attributes) }
  end

  factory :propay_merchant_request_data, class: Hash do
    defaults = {
      "PersonalData" => FactoryBot.build(:personal_data),
      "SignupAccountData" => FactoryBot.build(:signup_account_data),
      "BusinessData" => FactoryBot.build(:business_data),
      "Address" => FactoryBot.build(:address),
      "BusinessAddress" => FactoryBot.build(:business_address),
      "BankAccount" => FactoryBot.build(:bank_account),
      "BeneficialOwnerData" => FactoryBot.build(:beneficial_owner_data),
    }

    initialize_with{ defaults.merge(attributes) }
  end
end
