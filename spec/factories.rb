# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'A username' }
    password { 'My Password' }
  end

  factory :order do
    name { 'A name' }
    address { 'An address' }
    email { 'an@email.com' }
    pay_type { 'Credit card' }

    after(:create) do |order|
      create_list(:line_item, 2, order: order, cart: nil)

      # You may need to reload the record here, depending on your application
      order.reload
    end
  end

  factory :product do
    sequence(:title) { |n| "Product Title ##{n}" }
    description { 'A product description' }
    image_url { 'trakinas.jpg' }
    price { 4.99.to_d }

    factory :another_product do
      sequence(:title) { |n| "Product Title ##{n}" }
      description { 'Another description' }
      image_url { 'bono.jpg' }
      price { 99.99.to_d }
    end
  end

  factory :cart do
    # Cart has no attributes as of yet
  end

  factory :line_item do
    product
    cart
    product_price { 0.to_d }
  end
end
