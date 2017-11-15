require 'rails/generators/active_record/migration'

module Spree
  class CustomUserGenerator < Rails::Generators::NamedBase
    include Rails::Generators::ResourceHelpers
    include ActiveRecord::Generators::Migration

    desc "Set up a Solidus installation with a custom User class"

    def self.source_paths
      paths = superclass.source_paths
      paths << File.expand_path('../templates', __FILE__)
      paths.flatten
    end

    def check_for_constant
      klass
    rescue NameError
      @shell.say "Couldn't find #{class_name}. Are you sure that this class exists within your application and is loaded?", :red
      exit(1)
    end

    def generate
      migration_template 'migration.rb.tt', "db/migrate/add_spree_fields_to_custom_user_table.rb"
      template 'authentication_helpers.rb.tt', "lib/spree/authentication_helpers.rb"

      file_action = File.exist?('config/initializers/spree.rb') ? :append_file : :create_file
      send(file_action, 'config/initializers/spree.rb') do
        %{
          Rails.application.config.to_prepare do
            require_dependency 'spree/authentication_helpers'
          end\n}
      end
    end


    def klass
      class_name.constantize
    end

    def table_name
      klass.table_name
    end
  end
end
