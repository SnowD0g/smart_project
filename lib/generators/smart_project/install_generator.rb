# frozen_string_literal: true

require 'rails/generators/base'

module SmartProject
  module Generators
    MissingORMError = Class.new(Thor::Error)

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../", __FILE__)

      def configure_application
        application_type = ask('Tipo di applicazione [a]pi / [w]eb ?')

        copy_file 'lib/endpoints.yml', 'config/endpoints.yml'
        copy_file 'lib/warden.rb', 'config/initializers/warden.rb'
        append_to_file 'app/controllers/application_controller.rb', 'include SmartProject::Helpers::Session'
        append_to_file 'app/controllers/application_controller.rb', 'config.endpoints = config_for(:endpoints)'
        case application_type
        when 'a'
        puts 'api'
        content = <<-RUBY
          config.middleware.use Warden::Manager do |manager|
            manager.default_strategies :token
            manager.failure_app = ->(env){ SmartProject::Error::UnauthorizedApiController.action(:index).call(env) }
          end
        RUBY
        append_to_file 'config/application.rb', content
        append_to_file 'config/initializers/warden.rb', 'Warden::Strategies.add(:session, SmartProject::Strategies::Session)'
        append_to_file 'app/controllers/application_controller.rb', 'skip_before_action :verify_authenticity_token'
        when 'w'
        puts 'web'
        content = <<-RUBY
          config.middleware.use Warden::Manager do |manager|
            manager.default_strategies :session
            manager.failure_app = ->(env){ SmartProject::Error::UnauthorizedWebController.action(:index).call(env) }
          end
        RUBY
        append_to_file 'config/application.rb', content
        append_to_file 'config/initializers/warden.rb', 'Warden::Strategies.add(:token, SmartProject::Strategies::Token)'
        end
      end
    end
  end
end
