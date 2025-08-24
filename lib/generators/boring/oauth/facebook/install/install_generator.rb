# frozen_string_literal: true

require 'bundler'
require 'boring_generators/generator_helper'
require 'generators/boring/oauth/base_generator'

module Boring
  module Oauth
    module Facebook
      class InstallGenerator < Rails::Generators::Base
        include BoringGenerators::GeneratorHelper
        include Boring::Oauth::BaseGenerator

        class MissingDeviseConfigurationError < StandardError; end

        desc "Adds facebook OmniAuth to the application"
        source_root File.expand_path("templates", __dir__)

        def add_facebook_omniauth_gem
          say "Adding Facebook OmniAuth gem", :green
          Bundler.with_unbundled_env do
            run "bundle add omniauth-facebook"
          end
        end

        def invoke_common_generator_methods
          add_omniauth_rails_csrf_protection_gem
          @oauth_name = :facebook
          add_provider_and_uuid_user_details
          configure_devise_omniauth
          add_omniauth_callback_routes
          add_omniauth_callback_controller
          configure_and_add_devise_setting_in_user_model
          show_readme
        end
      end
    end
  end
end
