#application.rb
config.autoload_paths += %W( lib/ )
config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :session # webapplication
  manager.default_strategies :token   # api
end

#initializer/warden.rb

require Rails.root.join('lib/smart_project/strategies/session')

Warden::Strategies.add(:session, SmartProject::Strategies::Session)