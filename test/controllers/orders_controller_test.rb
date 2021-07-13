require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @user = users(:one)
  end

  test 'should get index' do
    login_as(@user)

    get orders_url
    assert_response :success
  end

  test 'require item in cart' do
    get new_order_url
    assert_redirected_to store_index_path
    assert_equal flash[:notice], 'Your cart is empty'
  end

  test 'should get new' do
    post line_items_url, params: { product_id: products(:ruby).id }
    get new_order_url
    assert_response :success
  end

  test 'should create order' do
    post line_items_url, params: { product_id: products(:ruby).id }
    assert_difference('Order.count') do
      post orders_url,
           params: {
             order: {
               address: @order.address, email: @order.email, name: @order.name,
               pay_type: 'Check', account_number: '1111111111111',
               routing_number: '2222222222222222'
             }
           }
    end

    assert_redirected_to store_index_url
  end

  test 'should show order' do
    login_as(@user)

    get order_url(@order)
    assert_response :success
  end

  test 'should get edit' do
    login_as(@user)

    get edit_order_url(@order)
    assert_response :success
  end

  test 'should update order' do
    login_as(@user)

    patch order_url(@order),
          params: { order: { address: @order.address, email: @order.email, name: @order.name,
                             pay_type: @order.pay_type } }
    assert_redirected_to order_url(@order)
  end

  test 'should destroy order' do
    login_as(@user)

    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
