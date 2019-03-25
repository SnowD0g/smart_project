module NotFound
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_exception

    private

    def not_found_exception(exception)
      render json: { errors: exception.message }, status: :not_found
    end
  end
end