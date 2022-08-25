# frozen_string_literal: true

require 'spree/frontend/search/base'

module Spree
  class FrontendConfiguration < Preferences::Configuration
    preference :locale, :string, default: I18n.default_locale

    # Add your terms and conditions in app/views/spree/checkout/_terms_and_conditions.en.html.erb
    preference :require_terms_and_conditions_acceptance, :boolean, default: false

    # @!attribute [rw] products_per_page
    #   @return [Integer] Products to show per-page in the frontend (default: +12+)
    preference :products_per_page, :integer, default: 12

    # @!attribute [rw] show_products_without_price
    #   @return [Boolean] Whether products without a price are visible in the frontend (default: +false+)
    preference :show_products_without_price, :boolean, default: false

    class_name_attribute :searcher_class, default: 'Spree::Frontend::Search::Base'
  end
end
