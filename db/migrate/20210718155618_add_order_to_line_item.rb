# frozen_string_literal: true

# adds reference from line_items to orders, and also allows
# a line_item to no longer have to belong to a cart
class AddOrderToLineItem < ActiveRecord::Migration[6.1]
  def up
    add_reference :line_items, :order, null: true, foreign_key: true
    change_column :line_items, :cart_id, :bigint, null: true
  end

  def down
    remove_reference :line_items, :order
    change_column :line_items, :cart_id, :bigint, null: false
  end
end
