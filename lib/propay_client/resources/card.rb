module PropayClient
  class Card < API
    def self.create(account_number, params)
      put("/propayapi/FlashFundsCard/#{account_number}", body: params)
    end

    def self.update(account_number, params)
      put("/propayapi/FlashFundsCard/#{account_number}", body: params)
    end

    def self.push_funds_to_flash_funds_card(account_number, params)
      put("/propayAPI/PushFundsToFlashFundsCard/#{account_number}", body: params)
    end
  end
end
