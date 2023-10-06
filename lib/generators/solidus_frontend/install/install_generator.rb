# frozen_string_literal: true

module SolidusFrontend
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      class_option :auto_accept, type: :boolean, default: false

      def self.exit_on_failure?
        true
      end

      def copy_initializer
        template 'initializer.rb', 'config/initializers/solidus_frontend.rb'
      end

      def robots_directives
        FileUtils.touch "public/robots.txt"
        append_file "public/robots.txt", <<-ROBOTS.strip_heredoc
          User-agent: *
          Disallow: /checkout
          Disallow: /cart
          Disallow: /orders
          Disallow: /user
          Disallow: /account
          Disallow: /api
          Disallow: /password
        ROBOTS
      end

      def setup_assets
        empty_directory 'app/assets/images'

        %w{javascripts stylesheets images}.each do |path|
          empty_directory "vendor/assets/#{path}/spree/frontend"
        end

        template "vendor/assets/javascripts/spree/frontend/all.js"
        template "vendor/assets/stylesheets/spree/frontend/all.css"
      end

      def install_solidus_bolt
        return if ENV['SKIP_SOLIDUS_BOLT'] || !File.exist?('Gemfile') || !(options[:auto_accept] || yes?(<<~MSG))
          Would you like to add bolt (https://www.bolt.com) as a default payment method?

          If you answer yes, solidus_bolt (https://github.com/solidusio/solidus_bolt)
          will be added to the installation (y/n):
        MSG

        gem 'solidus_bolt'
        bundle_cleanly { `bundle` }
        generate 'solidus_bolt:install --auto-run-migrations'
      end

      private

      def bundle_cleanly(&block)
        Bundler.respond_to?(:with_unbundled_env) ? Bundler.with_unbundled_env(&block) : Bundler.with_clean_env(&block)
      end
    end
  end
end
