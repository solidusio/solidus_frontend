# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Frontend::ControllerHelpers::Search, type: :controller do
  controller(ApplicationController) {
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Pricing
    include Spree::Frontend::ControllerHelpers::Search
  }

  describe '#build_searcher' do
    it 'returns Spree::Core::Search::Base instance' do
      allow(controller).to receive_messages(
        spree_current_user: create(:user),
        current_pricing_options: Spree::Config.pricing_options_class.new(currency: 'USD')
      )
      expect(controller.build_searcher({}).class).to eq Spree::Frontend::Search::Base
    end
  end
end
