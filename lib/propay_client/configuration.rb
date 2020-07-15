module PropayClient
  class Configuration
    attr_accessor :endpoint, :api_key

    def initialize
      @endpoint = nil
      @api_key = nil
    end
  end
end
