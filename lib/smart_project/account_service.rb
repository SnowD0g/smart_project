module SmartProject
  class AccountService
    def self.get_token!(credentials)
      response = Faraday.new(url: "#{Rails.configuration.endpoints['authentication']}/api/v1/").post do |req|
        req.url 'user_token'
        req.headers['Content-Type'] = 'application/json'
        req.body = { auth: credentials }.to_json
      end

      case response.status
      when 201 then return SmartProject::Token.new(response.headers['authorization'].split('Bearer ').last)
      when 404 then raise ActiveRecord::RecordNotFound
      end
    end
  end

  class Token
    attr_reader :jwt, :payload

    def initialize(jwt)
      @jwt = jwt
      @payload, _ = JWT.decode(jwt, Rails.application.credentials.jwt_secret, true)
    end
  end
end
