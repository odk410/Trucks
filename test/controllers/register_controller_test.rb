require 'test_helper'

class RegisterControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get register_info_url
    assert_response :success
  end

  test "should get registration" do
    get register_registration_url
    assert_response :success
  end

  test "should get registraion_email" do
    get register_registraion_email_url
    assert_response :success
  end

end
