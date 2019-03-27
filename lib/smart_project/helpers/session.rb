module SmartProject::Helpers::Session
  extend ActiveSupport::Concern

  included do
    def signed_in?
      raise SmartProject::Error::Unauthorized unless current_user.present?
    end

    def authenticate_user!
      current_user.present?
    end

    def current_user
      #"SmartProject::Authentication::#{user_type}".constantize.new(user_payload)
      warden.user
    end

    def warden
      request.env['warden']
    end

    def authenticate!
      warden.authenticate!
    end

    private

    def user_type
      user_payload['type']
    end

    def user_payload
      warden.user
    end

    helper_method :signed_in?, :current_user, :warden, :authenticate!
  end
end
