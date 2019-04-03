require 'smart_project/account_service'

module SmartProject::Strategies
  class Token < ::Warden::Strategies::Base
    METHOD = 'Bearer'

    def valid?
      token.present?
    end

    def authenticate!
      begin
        smart_token = SmartProject::Token.new(token).payload
        user = "SmartProject::Authentication::#{smart_token.payload['type']}".constantize.new(smart_token)
      rescue
        raise SmartProject::Error::Unauthorized
      end
      user.nil? ? fail!('strategies.session.failed') : success!(user)
    end

    private

    def authentication_token
      session.has_key?(:token_payload)
    end

    def token
      auth = authorization_header
      return nil unless auth

      method, token = auth.split
      method == METHOD ? token : nil
    end

    def authorization_header
      env['HTTP_AUTHORIZATION']
    end
  end
end
