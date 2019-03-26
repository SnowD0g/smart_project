# frozen_string_literal: true

require 'rails/generators/base'

module SmartProject
  module Generators
    MissingORMError = Class.new(Thor::Error)

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../", __FILE__)

      mattr_accessor :application_type
      @@application_type = ask_with_default('Tipo di applicazione [a]pi / [w]eb', 'w')

      case application_type
      when 'w' then setup_web_application
      when 'a' then setup_api_application
      end
        
      common_setup

      def api?
        application_type == 'a'
      end

      def web?
        !api?
      end

      def setup_web_application
          content = <<-RUBY
            config.middleware.use Warden::Manager do |manager|
              manager.default_strategies :session
              manager.failure_app = ->(env){ SmartProject::Error::UnauthorizedWebController.action(:index).call(env) }
            end
          RUBY

        append_to_file 'config/application.rb', content
        append_to_file 'config/initializers/warden.rb', 'Warden::Strategies.add(:token, SmartProject::Strategies::Token)'
      end
        
      def setup_api_application
          content = <<-RUBY
            config.middleware.use Warden::Manager do |manager|
              manager.default_strategies :token
              manager.failure_app = ->(env){ SmartProject::Error::UnauthorizedApiController.action(:index).call(env) }
            end
          RUBY
        append_to_file 'config/application.rb', content
        append_to_file 'config/initializers/warden.rb', 'Warden::Strategies.add(:session, SmartProject::Strategies::Session)'
        append_to_file 'app/controllers/application.rb', 'skip_before_action :verify_authenticity_token'
      end
        
      def common_setup
        copy_file 'config/endpoints.yml', 'config/endpoints.yml'
        copy_file 'config/initializers/warden.rb', 'config/initializers/warden.rb'

        append_to_file 'app/controllers/application.rb', 'include SmartProject::Helpers::Session'
        append_to_file 'app/controllers/application.rb', 'config.endpoints = config_for(:endpoints)'       
      end

      def ask_with_default(question, default, color = :blue)
        return default unless $stdin.tty?
        question = (question.split("?") << " [#{default}]?").join
        answer = ask(question, color)
        answer.to_s.strip.empty? ? default : answer
      end
    end
  end
end
