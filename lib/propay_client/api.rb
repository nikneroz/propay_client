module PropayClient
  class API
    def self.headers
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Basic #{PropayClient.configuration.api_key}"
      }  
    end

    def self.endpoint
      PropayClient.configuration.endpoint   
    end

    def self.put(path, body: {}, headers: headers())
      response = Excon.put("#{endpoint()}#{path}", body: body.to_json, headers: headers())
      return JSON.parse(response.body) if response.status == 200
      response.body
    end
  end
end
