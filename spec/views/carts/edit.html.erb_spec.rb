# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'carts/edit', type: :view do
  let!(:cart) { assign(:cart, Cart.create!) }

  it 'renders the edit cart form' do
    render

    assert_select 'form[action=?][method=?]', cart_path(cart), 'post'
  end
end
