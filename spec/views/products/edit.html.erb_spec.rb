# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'products/edit', type: :view do
  before do
    @product = assign(:product, create(:product))
  end

  it 'renders the edit product form' do
    render

    assert_select 'form[action=?][method=?]', product_path(@product), 'post' do
    end
  end
end
