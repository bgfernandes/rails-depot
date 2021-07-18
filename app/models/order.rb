# frozen_string_literal: true

# A customer order
class Order < ApplicationRecord
  enum pay_type: {
    'Check' => 0,
    'Credit cart' => 1,
    'Purchase order' => 2
  }
end
