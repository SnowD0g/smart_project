require "smart_project/version"

module SmartProject
  class Error < StandardError; end
  autoload :AccountService,     'smart_project/account_service'
  autoload :Authentication,     'smart_project/authentication'
  autoload :Error,              'smart_project/error'
  autoload :Delegator,          'smart_project/delegator'

  module Helpers
    autoload :Session,          'smart_project/helpers/session'
  end

  module Strategies
    autoload :Delegator,        'smart_project/strategies/session'
    autoload :Delegator,        'smart_project/strategies/token'
  end
end
