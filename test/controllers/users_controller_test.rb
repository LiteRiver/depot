require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should get index' do
    login_as(@user)

    get users_url
    assert_response :success
  end

  test 'should get new' do
    login_as(@user)

    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    login_as(@user)

    assert_difference('User.count') do
      post users_url, params: { user: { name: 'zhxch', password: 'secret', password_confirmation: 'secret' } }
    end

    assert_redirected_to users_url
  end

  test 'should show user' do
    login_as(@user)

    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    login_as(@user)

    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    login_as(@user)

    patch user_url(@user), params: { user: { name: 'hello world', current_password: 'secret' } }
    assert_redirected_to users_url
  end

  test 'should destroy user' do
    login_as(@user)

    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
