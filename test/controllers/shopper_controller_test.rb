require "test_helper"

class ShopperControllerTest < ActionDispatch::IntegrationTest
  test "should get catalog" do
    get shopper_catalog_url
    assert_response :success
  end
end
