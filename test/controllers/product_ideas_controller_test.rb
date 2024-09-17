require "test_helper"

class ProductIdeasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_ideas_index_url
    assert_response :success
  end

  test "should get show" do
    get product_ideas_show_url
    assert_response :success
  end

  test "should get new" do
    get product_ideas_new_url
    assert_response :success
  end

  test "should get create" do
    get product_ideas_create_url
    assert_response :success
  end

  test "should get edit" do
    get product_ideas_edit_url
    assert_response :success
  end

  test "should get update" do
    get product_ideas_update_url
    assert_response :success
  end

  test "should get destroy" do
    get product_ideas_destroy_url
    assert_response :success
  end
end
