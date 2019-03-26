# frozen_string_literal: true

require 'rails/generators/base'

module SmartProject
  module Generators
    MissingORMError = Class.new(Thor::Error)

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../../", __FILE__)

      def copy_flash_helper
        copy_file "app/helpers/theme.rb", "app/helpers/theme.rb"
      end

      def add_assets_to_precompile
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( base/vendors.bundle.js )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( demo/default/base/scripts.bundle.js )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( snippets/custom/pages/login.js )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( notify.js )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( misc/notification_bg.jpg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( misc/quick_actions_bg.jpg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( flags/020-flag.svg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( flags/015-china.svg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( flags/016-spain.svg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( flags/014-japan.svg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( flags/017-germany.svg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( users/user4.jpg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( misc/user_profile_bg.jpg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( logo/logo_default_dark.png )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( blog/blog1.jpg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( users/user1.jpg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( bg/bg-4.jpg )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( client-logos/logo1.png )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( client-logos/logo2.png )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( client-logos/logo3.png )\n"
        append_to_file "config/initializers/assets.rb", "Rails.application.config.assets.precompile += %w( logos/logo-2.png )\n"
      end
    end
  end
end
