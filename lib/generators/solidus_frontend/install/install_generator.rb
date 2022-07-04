# frozen_string_literal: true

module SolidusFrontend
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        template 'initializer.rb', 'config/initializers/solidus_frontend.rb'
      end

      def setup_assets
        empty_directory 'app/assets/images'

        %w{javascripts stylesheets images}.each do |path|
          empty_directory "vendor/assets/#{path}/spree/frontend"
        end

        template "vendor/assets/javascripts/spree/frontend/all.js"
        template "vendor/assets/stylesheets/spree/frontend/all.css"
      end
    end
  end
end
