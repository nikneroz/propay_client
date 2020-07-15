module PropayClient::API
  class Merchant
    # build(:propay_account_request_data)
    def self.create(params)
      headers = {
        'Content-Type'=> 'application/json',
        'Authorization' => "Basic #{PropayClient.configuration.api_key}"
      }
      response = Excon.put("#{PropayClient.configuration.endpoint}/propayapi/signup", body: params.to_json, headers: headers)
      return JSON.parse(response.body) if response.status == 200
      response.body
    end
  end
end
