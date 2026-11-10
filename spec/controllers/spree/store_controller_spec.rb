# frozen_string_literal: true

require 'spec_helper'

describe Spree::StoreController, type: :controller do
  describe "#cart_link" do
    render_views

    it "renders the cart link" do
      get :cart_link
      expect(response.status).to eq(200)
      expect(response.body).to include("cart-info")
    end

    context "when the client's cached cart link is still fresh" do
      it "responds with not modified" do
        get :cart_link
        etag = response.headers["ETag"]

        request.headers["If-None-Match"] = etag
        get :cart_link
        expect(response.status).to eq(304)
        expect(response.body).to be_empty
      end
    end
  end
end
