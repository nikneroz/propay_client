module PropayClient
  class Card < API
    def self.create(account_number, params)
      put("/propayapi/FlashFundsCard/#{account_number}", body: params)
    end

    def self.update(account_number, params)
      put("/propayapi/FlashFundsCard/#{account_number}", body: params)
    end
  end
end
