# frozen_string_literal: true

require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  before do
    @line_item = create(:line_item)
  end

  test 'should get index' do
    get line_items_url
    assert_response :success
  end

  test 'should get new' do
    get new_line_item_url
    assert_response :success
  end

  test 'should create line_item' do
    product = create(:product)

    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: product.id }
    end

    follow_redirect!
    assert_select 'h2', 'Your Cart'
    assert_select 'td', product.title
  end

  test 'should increase line_item quantity if product is already present in cart' do
    product = create(:product)

    assert_difference('LineItem.count', 1) do
      post line_items_url, params: { product_id: product.id }
      post line_items_url, params: { product_id: product.id }
    end

    follow_redirect!
    assert_select 'h2', 'Your Cart'
    assert_select 'td', product.title
    assert_select 'td', '2'
  end

  test 'should show line_item' do
    get line_item_url(@line_item)
    assert_response :success
  end

  test 'should get edit' do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test 'should update line_item' do
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test 'should destroy line_item' do
    assert_difference('LineItem.count', -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to line_items_url
  end
end
