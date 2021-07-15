require 'rails_helper'

RSpec.describe 'store/index', type: :view do
  let!(:a_product_in_store) { create(:product) }

  before do
    assign(:products, [
             create(:product),
             create(:product),
             a_product_in_store
           ])
  end

  it 'renders a list of products' do
    render

    assert_select 'h1', 'Catalog'
    assert_select 'ul.catalog li', 3
    assert_select 'h2', a_product_in_store.title
    assert_select '.price', /\$[,\d]+\.\d\d/
  end
end
