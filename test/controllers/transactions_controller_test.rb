require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get account_inquiry" do
    get transactions_account_inquiry_url
    assert_response :success
  end

end
