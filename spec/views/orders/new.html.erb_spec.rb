# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'orders/new', type: :view do
  let(:order) { build(:order) }

  before do
    assign(:order, order)
  end

  it 'renders the name input' do
    render

    assert_select 'form[action=?][method=?]', orders_path, 'post' do
      assert_select 'input[name=?]', 'order[name]'
    end
  end

  it 'renders the address input' do
    render

    assert_select 'form[action=?][method=?]', orders_path, 'post' do
      assert_select 'textarea[name=?]', 'order[address]'
    end
  end

  it 'renders the email input' do
    render

    assert_select 'form[action=?][method=?]', orders_path, 'post' do
      assert_select 'input[name=?]', 'order[email]'
    end
  end

  it 'renders the pay type input' do
    render

    assert_select 'form[action=?][method=?]', orders_path, 'post' do
      assert_select 'input[name=?]', 'order[pay_type]'
    end
  end
end
