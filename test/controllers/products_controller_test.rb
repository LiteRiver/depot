require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @title = "The Great Book #{rand(1000)}"
    @user = users(:one)
  end

  test 'should get index' do
    login_as(@user)

    get products_url
    assert_response :success
  end

  test 'should get new' do
    login_as(@user)

    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    login_as(@user)

    assert_difference('Product.count') do
      post products_url,
           params: {
             product: {
               description: @product.description,
               image_url: @product.image_url,
               price: @product.price,
               title: @title
             }
           }
    end

    assert_redirected_to product_url(Product.last)
  end

  test 'should show product' do
    login_as(@user)

    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    login_as(@user)

    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    login_as(@user)

    patch product_url(@product),
          params: {
            product: {
              description: @product.description,
              image_url: @product.image_url,
              price: @product.price,
              title: @title
            }
          }
    assert_redirected_to product_url(@product)
  end

  test 'should destroy product' do
    login_as(@user)

    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "can't delete product in cart" do
    login_as(@user)

    assert_difference('Product.count', 0) do
      delete product_url(products(:two))
    end

    assert_redirected_to products_url
  end
end
