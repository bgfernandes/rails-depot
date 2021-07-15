# REMOVING THIS FOR NOW - So it won't clash with the factories in spec/factories.rb

# FactoryBot.define do
#   factory :product do
#     sequence(:title) { |n| "Product Title ##{n}" }
#     description { "A product description" }
#     image_url { "trakinas.jpg" }
#     price { 4.99 }
#   end

#   factory :cart do
#   end

#   factory :line_item do
#     product
#     cart
#     product_price { 0 }
#   end
# end
