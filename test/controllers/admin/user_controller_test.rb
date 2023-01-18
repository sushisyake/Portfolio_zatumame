require "test_helper"

class Admin::UserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_user_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_user_show_url
    assert_response :success
  end
end
