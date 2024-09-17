require "test_helper"

class PrdsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get prds_new_url
    assert_response :success
  end

  test "should get create" do
    get prds_create_url
    assert_response :success
  end

  test "should get show" do
    get prds_show_url
    assert_response :success
  end
end
