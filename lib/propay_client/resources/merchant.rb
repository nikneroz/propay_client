module PropayClient
  class Merchant < API
    # build(:propay_account_request_data)
    def self.create(params)
      put("/propayapi/signup", body: params)
    end
  end
end
