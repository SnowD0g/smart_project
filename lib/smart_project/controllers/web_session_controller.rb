class SmartProject::Controllers::WebSessionController < ApplicationController
  layout SmartProject.session_layout

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_credential
  # GET /sessions/new
  def new
    render 'authentications/sessions/new'
  end

  def create
    token = SmartProject::AccountService.get_token!(params[:session])
    session[:token_payload] = token.payload
    authenticate!
    render 'authentications/sessions/new'
  end

  def destroy
    session.destroy
    render 'new'
  end

  def invalid_credential
    flash[:error] = 'Credenziali Errate'
    render 'authentications/sessions/new'
  end

  def resource
    instance_variable_set(:@resource, OpenStruct.new({email:'', password: '', param_key: 'session'} ))
  end

  def resource_name
    'session'
  end

  def session_path(resource_name)
    sessions_path
  end

  helper_method :resource, :resource_name, :session_path
end
