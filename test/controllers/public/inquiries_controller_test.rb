require 'test_helper'

class Public::InquiriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_inquiries_new_url
    assert_response :success
  end

  test "should get confirm" do
    get public_inquiries_confirm_url
    assert_response :success
  end

end
