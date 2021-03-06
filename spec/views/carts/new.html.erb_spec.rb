# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'carts/new', type: :view do
  before do
    assign(:cart, Cart.new)
  end

  it 'renders new cart form' do
    render

    assert_select 'form[action=?][method=?]', carts_path, 'post'
  end
end
