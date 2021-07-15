require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '.add_product' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:line_item) { cart.add_product(product) }

    let(:updated_product) { product.price = 99; product }
    let(:updated_line_item) { line_item.cart.add_product(updated_product) }

    it 'sets the product_price in line_item when adding a new product' do
      expect(line_item.product_price).to eq(product.price)
    end

    it 'updates the product_price in line_item when adding the same product again' do
      expect(updated_line_item.product_price).to eq(updated_product.price)
    end
  end
end
