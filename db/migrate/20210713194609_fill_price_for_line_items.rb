# frozen_string_literal: true

class FillPriceForLineItems < ActiveRecord::Migration[6.1]
  def up
    LineItem.all.each do |line_item|
      line_item.product_price = line_item.product.price
      line_item.save!
    end
  end

  def down
    LineItem.all.each do |line_item|
      line_item.product_price = 0
      line_item.save!
    end
  end
end
