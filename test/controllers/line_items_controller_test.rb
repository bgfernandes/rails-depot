require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:trakinas).id }
    end

    follow_redirect!
    assert_select 'h2', 'Your Cart'
    assert_select 'li', "1 \u00D7 Cookie Trakinas"
  end

  test "should increase line_item quantity if product is already present in cart" do
    assert_difference('LineItem.count', 1) do
      post line_items_url, params: { product_id: products(:trakinas).id }
      post line_items_url, params: { product_id: products(:trakinas).id }
    end

    follow_redirect!
    assert_select 'h2', 'Your Cart'
    assert_select 'li', "2 \u00D7 Cookie Trakinas"
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to line_items_url
  end
end
