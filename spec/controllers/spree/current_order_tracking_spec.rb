# frozen_string_literal: true

require 'spec_helper'

describe 'current order tracking', type: :controller do
  let!(:store) { create(:store) }
  let(:user) { create(:user) }

  controller(Spree::StoreController) do
    def index
      head :ok
    end
  end

  let(:order) { FactoryBot.create(:order) }

  it 'automatically tracks who the order was created by & IP address' do
    allow(controller).to receive_messages(spree_current_user: user)
    get :index
    expect(controller.current_order(create_order_if_necessary: true).created_by).to eq controller.spree_current_user
    expect(controller.current_order.last_ip_address).to eq "0.0.0.0"
  end

  context "current order creation" do
    before { allow(controller).to receive_messages(spree_current_user: user) }

    it "doesn't create a new order out of the blue" do
      expect {
        get :index
      }.not_to change { Spree::Order.count }
    end
  end
end
