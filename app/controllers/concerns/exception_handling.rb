module ExceptionHandling
  extend ActiveSupport::Concern
  include NotFound

  included do
    rescue_from ActionController::InvalidAuthenticityToken, ActiveRecord::RecordInvalid, with: :invalid_record
    rescue_from SmartProject::Error::Unauthorized, with: :unauthorized

    def invalid_record(exception)
      render json: { errors: exception.record.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end

    def unauthorized
      head(:unauthorized)
    end
  end
end
