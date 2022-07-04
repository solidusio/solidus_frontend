# frozen_string_literal: true

require 'rails/generators'
require 'rails/version'

module Solidus
  # @private
  class InstallGenerator < Rails::Generators::Base
    def self.source_paths
      paths = superclass.source_paths
      paths << File.expand_path('../templates', "../../#{__FILE__}")
      paths << File.expand_path('../templates', "../#{__FILE__}")
      paths << File.expand_path('templates', __dir__)
      paths.flatten
    end

    def add_files
      template 'config/initializers/spree.rb.tt', 'config/initializers/spree.rb'
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
