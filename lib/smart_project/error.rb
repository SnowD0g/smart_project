module SmartProject::Error
  class Unauthorized < StandardError
  end

  class UnauthorizedApiController < ActionController::API
    def index
      head(:unauthorized)
    end
  end

  class UnauthorizedWebController < ApplicationController
    def index
      redirect_to root_url, alert: t('authentication.errors.user_required')
    end
  end
end
