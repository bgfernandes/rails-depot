# frozen_string_literal: true

# create the carts table
class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts, &:timestamps
  end
end
