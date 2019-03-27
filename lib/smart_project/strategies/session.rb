module SmartProject::Strategies
  class Session < ::Warden::Strategies::Base
    def valid?
      authentication_session
    end

    def authenticate!
      user = "SmartProject::Authentication::#{payload['type']}".constantize.new(payload)
      user.nil? ? fail!('strategies.session.failed') : success!(user)
    end

    private

    def authentication_session
      session.has_key?(:token_payload)
    end

    def payload
      HashWithIndifferentAccess.new(session[:token_payload])
    end
  end
end
