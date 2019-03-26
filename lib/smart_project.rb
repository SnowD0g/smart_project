require "smart_project/version"

module SmartProject
  autoload :AccountService, 'smart_project/account_service'
  autoload :Authentication, 'smart_project/authentication'
  autoload :Error, 'smart_project/error'
  autoload :Delegator, 'smart_project/delegator'

  module Helpers
    autoload :Session, 'smart_project/helpers/session'
  end

  module Strategies
    autoload :Session, 'smart_project/strategies/session'
    autoload :Token, 'smart_project/strategies/token'
  end
  
  mattr_accessor :test
  @@test = 'ciao'
  
  def self.setup
    yield self
  end
end
