class CombineLineItemsInCart < ActiveRecord::Migration[6.1]
  def up
    # Combines line_items in the same cart and same product into a single line_item
    # with the correct quantity.
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        next unless quantity > 1

        # remove individual items
        cart.line_items.where(product_id: product_id).delete_all

        # replace with a single item
        line_item = cart.line_items.build(product_id: product_id)
        line_item.quantity = quantity
        line_item.save!
      end
    end
  end

  def down
    # Splits line_items with quantity > 1 into multiple line_items of quantity 1
    LineItem.where('quantity > 1').each do |line_item|
      line_item.quantity.times do
        LineItem.create(
          cart_id: line_item.cart_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end

      line_item.destroy
    end
  end
end
