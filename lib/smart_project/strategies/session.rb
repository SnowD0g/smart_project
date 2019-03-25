module SmartProject::Strategies
  class Session < ::Warden::Strategies::Base
    def valid?
      authentication_session
    end

    def authenticate!
      user_payload.nil? ? fail!('strategies.session.failed') : success!(user_payload)
      # user = "SmartProject::Authentication::#{payload['type']}".constantize.new(payload)
      # user.nil? ? fail!('strategies.session.failed') : success!(user)
    end

    private

    def authentication_session
      session.has_key?(:token_payload)
    end

    def user_payload
      HashWithIndifferentAccess.new(session[:token_payload])
    end
  end
end
