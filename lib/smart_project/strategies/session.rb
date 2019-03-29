require 'smart_project/account_service'

module SmartProject::Strategies
  class Session < ::Warden::Strategies::Base
    def valid?
      authentication_session
    end

    def authenticate!
      begin
        user = "SmartProject::Authentication::#{payload['type']}".constantize.new(payload)
      rescue
        raise SmartProject::Error::Unauthorized
      end
      user.nil? ? fail!('strategies.session.failed') : success!(user)
    end

    private

    def authentication_session
      session.has_key?('warden.user.default.key') || params.has_key?('session')
    end

    def payload
      payload = session['warden.user.default.key'] || SmartProject::AccountService.get_token!(params['session']).payload
      HashWithIndifferentAccess.new(payload)
    end
  end
end
