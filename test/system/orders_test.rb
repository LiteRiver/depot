require 'application_system_test_case'

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test 'check routing number' do
    visit store_index_url

    first('.catalog li').click_on('Add to Cart')
    click_on('Checkout')
    fill_in('order_name', with: 'Dave Thomas')
    fill_in('order_address', with: '320 w ohio st')
    fill_in('order_email', with: 'some@a.edu')
    assert_no_selector('#order_routing_number')
    select('Check', from: 'pay_type')
    assert_selector('#order_routing_number')
  end
end
