require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test 'should get index' do
    login_as(@user)

    get admin_url
    assert_response :success
  end
end
