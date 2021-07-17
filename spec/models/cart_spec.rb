# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '.add_product' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:line_item) { cart.add_product(product) }

    let(:updated_product) do
      product.price = 99
      product
    end
    let(:updated_line_item) { line_item.cart.add_product(updated_product) }

    it 'sets the product_price in line_item when adding a new product' do
      expect(line_item.product_price).to eq(product.price)
    end

    it 'updates the product_price in line_item when adding the same product again' do
      expect(updated_line_item.product_price).to eq(updated_product.price)
    end

    context 'when passing a product id as parameter' do
      subject(:line_item_created_with_product_id) { cart.add_product(product.id) }

      it 'also works' do
        expect(line_item_created_with_product_id.product_price).to eq(product.price)
      end
    end
  end
end
