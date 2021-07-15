FactoryBot.define do
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
  end

  factory :line_item do
    product
    cart
    product_price { 0.to_d }
  end
end
