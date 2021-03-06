module PropayClient
  class Merchant < API
    # build(:propay_account_request_data)
    def self.create(params)
      put("/propayapi/signup", body: params)
    end

    def self.balance(account_number)
      get("/propayAPI/MerchantBalanceDetails/#{account_number}")
    end

    def self.edit_contact_info(account_number, params)
      put("/propayAPI/MerchantContactInfo/#{account_number}", body: params)
    end

    def self.edit_address(account_number, params)
      put("/propayAPI/MerchantAddress/#{account_number}", body: params)
    end

    def self.edit_renewal_payment_method(account_number, params)
      put("/propayAPI/MerchantPaymentInformation/#{account_number}", body: params)
    end

    def self.edit_business_info(account_number, params)
      put("/propayAPI/MerchantBusinessInfo/#{account_number}", body: params)
    end

    def self.edit_bank_account(account_number, params)
      put("/propayAPI/MerchantBankAccount/#{account_number}", body: params)
    end

    def self.edit_gross_settle_payment_info(account_number, params)
      put("/propayAPI/MerchantGrossSettleBilling/#{account_number}", body: params)
    end

    def self.edit_services(account_number, params)
      put("/propayAPI/MerchantServices/#{account_number}", body: params)
    end
    
    def self.edit_status(account_number, params)
      put("/propayAPI/MerchantStatus/#{account_number}", body: params)
    end

    def self.edit_credit_limit(account_number, params)
      put("/propayAPI/MerchantCreditLimit/#{account_number}", body: params)
    end
  end
end
