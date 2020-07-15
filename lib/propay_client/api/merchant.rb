module PropayClient::API
  class Merchant
    class << self
      # build(:propay_account_request_data)
      def create(params)
        headers = {
          'Content-Type'=> 'application/json',
          'Authorization' => "Basic #{ENV['API_TOKEN']}"
        }
        response = Excon.put("https://xmltestapi.propay.com/propayapi/signup", body: params.to_json, headers: headers)
        return JSON.parse(response.body) if response.status == 200
        response.body
      end
    end
  end
end
