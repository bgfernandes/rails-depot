FactoryBot.define do
  factory :product do
    sequence(:title) { |n| "Product Title ##{n}" }
    description { "A product description" }
    image_url { "trakinas.jpg" }
    price { 4.99 }
  end
end
