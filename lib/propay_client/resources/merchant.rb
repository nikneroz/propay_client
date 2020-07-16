module PropayClient
  class Merchant < API
    # build(:propay_account_request_data)
    def self.create(params)
      put("/propayapi/signup", body: params)
    end

    def self.edit_merchant_contact_info(account_number, params)
      put("/propayAPI/MerchantContactInfo/#{account_number}", body: params)
    end

    def self.edit_merchant_address(account_number, params)
      put("/propayAPI/MerchantAddress/#{account_number}", body: params)
    end
  end
end
