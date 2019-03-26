class Api::V1::BaseController < ApplicationController
  include Permission
  before_action :authenticate!
end
