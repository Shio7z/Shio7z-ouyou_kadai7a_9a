require "test_helper"

class ViewcountsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get viewcounts_create_url
    assert_response :success
  end
end
