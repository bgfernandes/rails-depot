# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'orders/edit', type: :view do
  let(:order) { create(:order) }

  before do
    @order = assign(:order, order)
  end

  it 'renders the name input' do
    render

    assert_select 'form[action=?][method=?]', order_path(order), 'post' do
      assert_select 'input[name=?]', 'order[name]'
    end
  end

  it 'renders the address input' do
    render

    assert_select 'form[action=?][method=?]', order_path(order), 'post' do
      assert_select 'textarea[name=?]', 'order[address]'
    end
  end

  it 'renders the email input' do
    render

    assert_select 'form[action=?][method=?]', order_path(order), 'post' do
      assert_select 'input[name=?]', 'order[email]'
    end
  end

  it 'renders the pay type component container' do
    render

    assert_select 'div#pay-type-component'
  end
end
