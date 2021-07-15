# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'products/index', type: :view do
  before do
    assign(:products, [
             create(:product),
             create(:product)
           ])
  end

  it 'renders a list of products' do
    render
  end
end
