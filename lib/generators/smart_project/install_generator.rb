# frozen_string_literal: true

require 'rails/generators/base'

module SmartProject
  module Generators
    MissingORMError = Class.new(Thor::Error)

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../", __FILE__)

      mattr_accessor :application_type
      application_type = ask_with_default('Tipo di applicazione [a]pi / [w]eb', 'w')
      
      def ask_with_default(question, default, color = :blue)
        return default unless $stdin.tty?
        question = (question.split("?") << " [#{default}]?").join
        answer = ask(question, color)
        answer.to_s.strip.empty? ? default : answer
      end
    end
  end
end
