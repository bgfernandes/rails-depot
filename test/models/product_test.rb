# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'product price must be positive' do
    product = Product.new(
      title: 'This is a product',
      description: 'some description',
      image_url: 'someurl.jpg'
    )

    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def product_with_image_url(image_url)
    Product.new(
      title: 'This is a product',
      description: 'some description',
      price: 1,
      image_url: image_url
    )
  end

  test 'image_url must be valid' do
    ok = %w[some.gif some.jpg some.png SOME.JPG SOME.GIF some.GIF]
    bad = %w[some.doc some.gif/more what.gif.what]

    ok.each do |image_url|
      assert product_with_image_url(image_url).valid?, "#{image_url} should be valid"
    end

    bad.each do |image_url|
      assert product_with_image_url(image_url).invalid?, "#{image_url} should be invalid"
    end
  end

  test 'product tite must be unique' do
    existing_product = create(:product)

    product = Product.new(
      title: existing_product.title,
      description: 'some descritpion',
      price: 1,
      image_url: 'trakinas.jpg'
    )

    assert product.invalid?
    assert_equal ['has already been taken'], product.errors[:title]
  end

  test 'product title must have at least 10 characters' do
    product = Product.new(
      title: 'too small',
      description: 'some descritpion',
      price: 1,
      image_url: 'trakinas.jpg'
    )

    assert product.invalid?
    assert_equal ['is too short (minimum is 10 characters)'], product.errors[:title]

    product = Product.new(
      title: 'big enough',
      description: 'some descritpion',
      price: 1,
      image_url: 'trakinas.jpg'
    )

    assert product.valid?
  end
end
