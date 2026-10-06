# frozen_string_literal: true

require 'spec_helper'

module Spree
  describe Spree::OrdersHelper, type: :helper do
    # Regression test for https://github.com/spree/spree/issues/2518 and https://github.com/spree/spree/issues/2323
    it "truncates HTML correctly in product description" do
      product = double(description: "<strong>" + ("a" * 95) + "</strong> This content is invisible.")
      expected = "<strong>" + ("a" * 95) + "</strong>..."
      expect(truncated_product_description(product)).to eq(expected)
    end

    it "sanitizes event-handler markup in product description" do
      product = double(description: %(ATO <img src=x onerror="alert(1)"> <script>alert(2)</script>))

      description = truncated_product_description(product)

      expect(description).not_to include("onerror")
      expect(description).not_to include("<script")
      expect(description).to be_html_safe
    end

    it "handles a missing product description" do
      product = double(description: nil)

      expect(truncated_product_description(product)).to eq("")
    end

    context "when raw product descriptions are enabled" do
      before { stub_spree_preferences(show_raw_product_description: true) }

      it "does not sanitize the product description" do
        product = double(description: %(<img src=x onerror="alert(1)">))

        expect(truncated_product_description(product)).to include("onerror")
      end
    end
  end
end
