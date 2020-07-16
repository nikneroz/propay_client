module PropayClient
  class Account < API
    def self.renewal(params)
      put("/propayapi/renewal", body: params)
    end
  end
end
