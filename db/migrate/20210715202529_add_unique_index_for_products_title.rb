# frozen_string_literal: true

# adds unique index to products.title
class AddUniqueIndexForProductsTitle < ActiveRecord::Migration[6.1]
  def change
    add_index :products, :title, unique: true
  end
end
