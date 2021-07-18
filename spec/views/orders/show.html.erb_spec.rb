# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'orders/show', type: :view do
  let(:order) { create(:order) }

  before do
    @order = order
  end

  it 'renders the name' do
    render
    expect(rendered).to match(/#{order.name}/)
  end

  it 'renders the address' do
    render
    expect(rendered).to match(/#{order.address}/)
  end

  it 'renders the email' do
    render
    expect(rendered).to match(/#{order.email}/)
  end

  it 'renders the pay_type' do
    render
    expect(rendered).to match(/#{order.pay_type}/)
  end
end
