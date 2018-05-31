require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get error_404" do
    get errors_error_404_url
    assert_response :success
  end

end
