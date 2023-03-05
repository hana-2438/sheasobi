require "test_helper"

class Admin::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_members_index_url
    assert_response :success
  end

  test "should get confirm" do
    get admin_members_confirm_url
    assert_response :success
  end
end
