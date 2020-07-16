module PropayClient
  class Payment < API
    def self.propay_to_propay(params)
      put("/propayAPI/ProPayToProPay", body: params)
    end

    def self.timed_pull(params)
      put("/propayAPI/TimedPull", body: params)
    end
  end
end
