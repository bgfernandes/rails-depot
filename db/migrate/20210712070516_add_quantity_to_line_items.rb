# frozen_string_literal: true

# adds a quantity column in the line_items table
class AddQuantityToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :quantity, :integer, default: 1
  end
end
