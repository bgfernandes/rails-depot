# frozen_string_literal: true

# Creates the users table
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :name, unique: true
  end
end
