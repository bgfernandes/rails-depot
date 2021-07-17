# frozen_string_literal: true

# Represents a user store cart
class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    product = Product.find(product) unless product.instance_of?(Product)

    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
      current_item.product_price = product.price
    else
      current_item = line_items.build(product_id: product.id, product_price: product.price)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
