# frozen_string_literal: true

require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test 'when adding product to cart, set the line_item.product_price' do
    cart = Cart.new
    product = create(:product)
    cart.add_product(product)

    assert_equal product.price, cart.line_items.first.product_price
  end

  test 'when adding product to a cart, update the line_item.product_price if it is already there' do
    product = create(:product)
    cart = Cart.new
    cart.add_product(product).save!

    assert_equal product.price, cart.line_items.first.product_price

    product.price = 99.9
    cart.add_product(product).save!

    cart.reload

    assert_equal product.price, cart.line_items.first.product_price
  end
end
