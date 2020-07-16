module PropayClient
  class Document < API
    def self.upload(params)
      put("/propayapi/DocumentUpload", body: params)
    end
  end
end
