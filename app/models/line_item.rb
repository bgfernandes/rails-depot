# frozen_string_literal: true

# Each LineItem denotes that a particular Product is in a user Cart.
# The cart also stores a snapshot of the Product's price in product_price, in order to
# save the original rice in case the Product's price is changed after a user added it
# to the Cart
class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  def total_price
    product_price * quantity
  end
end
