# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'orders/index', type: :view do
  let(:an_order) { create(:order) }

  before do
    assign(:orders, [
             create(:order),
             create(:order)
           ])
  end

  it 'renders a list of orders' do
    render
    assert_select 'tr>td', text: an_order.name.to_s, count: 2
    assert_select 'tr>td', text: an_order.address.to_s, count: 2
    assert_select 'tr>td', text: an_order.email.to_s, count: 2
    assert_select 'tr>td', text: an_order.pay_type.to_s, count: 2
  end
end
