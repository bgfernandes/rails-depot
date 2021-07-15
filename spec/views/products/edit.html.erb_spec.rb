# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'products/edit', type: :view do
  let!(:product) { assign(:product, create(:product)) }

  it 'renders the edit product form' do
    render

    assert_select 'form[action=?][method=?]', product_path(product), 'post'
  end
end
