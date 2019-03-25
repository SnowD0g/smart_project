class ApplicationController < ActionController::Base

  helper_method :warden, :signed_in?, :current_user

  #prepend_before_action :authenticate!

  def signed_in?
    !current_user.nil?
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end
end
