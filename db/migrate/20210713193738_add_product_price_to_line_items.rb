# frozen_string_literal: true

# adds the product_price column to the line_items table
class AddProductPriceToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :product_price, :decimal, precision: 8, scale: 2, null: false, default: 0
  end
end
