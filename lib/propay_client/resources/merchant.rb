module PropayClient
  class Merchant < API
    # build(:propay_account_request_data)
    def self.create(params)
      put("/propayapi/signup", body: params)
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
      put("/propayAPI/MerchantPaymentInformation/#{account_number}", body: params)
    end
  end
end
