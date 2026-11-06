# frozen_string_literal: true

require 'spree/frontend/config'

module Spree
  module Frontend
    class Engine < ::Rails::Engine
      config.middleware.use "Spree::Frontend::Middleware::SeoAssist"

      # Leave initializer empty for backwards-compatability. Other apps
      # might still rely on this event.
      initializer "spree.frontend.environment", before: :load_config_initializers do; end

      config.after_initialize do
        Spree::Frontend::Config.check_load_defaults_called('Spree::Frontend::Config')
      end

      initializer "canonical_rails.add_helpers" do |app|
        ActiveSupport.on_load(:action_view) do
          self.include CanonicalRails::TagHelper
        end
      end
    end
  end
end
