# frozen_string_literal: true

require 'truncate_html'
require 'app/helpers/truncate_html_helper'

module Spree
  module OrdersHelper
    include TruncateHtmlHelper

    def truncated_product_description(product)
      if Spree::Config.show_raw_product_description
        truncate_html(raw(product.description))
      else
        truncate_html(sanitize(product.description))
      end
    end

    def order_just_completed?(order)
      flash[:order_completed] && order.present?
    end
  end
end
