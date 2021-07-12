require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
    @cart = carts(:one)
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
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    follow_redirect!
    assert_select 'h2', 'Your Cart'
    assert_select '.carts td', 'Programming Ruby 1.9'
  end

  test 'should create line_item via ajax' do
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:ruby).id }, xhr: true
    end

    assert_response(:success)

    assert_match(/<tr class=\\"line-item-highlight/, @response.body)
  end

  test 'should show line_item' do
    open_session do
      post line_items_url, params: { product_id: products(:ruby).id }
      cart = Cart.find(session[:cart_id])
      item = cart.line_items.last
      get line_item_url(item)
      assert_response :success
    end
  end

  test 'should get edit' do
    open_session do
      post line_items_url, params: { product_id: products(:ruby).id }
      cart = Cart.find(session[:cart_id])
      item = cart.line_items.last
      get edit_line_item_url(item)
      assert_response :success
    end
  end

  test 'should update line_item' do
    open_session do
      post line_items_url, params: { product_id: products(:ruby).id }
      cart = Cart.find(session[:cart_id])
      item = cart.line_items.last
      patch line_item_url(item), params: { line_item: { quantity: 2 } }
      assert_redirected_to line_item_url(item)
    end
  end

  test 'should destroy line_item' do
    open_session do
      post line_items_url, params: { product_id: products(:ruby).id }
      cart = Cart.find(session[:cart_id])
      item = cart.line_items.last

      assert_difference('LineItem.count', -1) do
        delete line_item_url(item)
      end
      assert_redirected_to cart_url(cart)
    end
  end
end
