require "test_helper"

class Admin::ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_articles_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_articles_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_articles_edit_url
    assert_response :success
  end
end
