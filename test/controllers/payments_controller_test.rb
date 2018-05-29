require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = payments(:one)
  end

  test "should get index" do
    get payments_url
    assert_response :success
  end

  test "should get new" do
    get new_payment_url
    assert_response :success
  end

  test "should create payment" do
    assert_difference('Payment.count') do
      post payments_url, params: { payment: { amount: @payment.amount, cancel_amount: @payment.cancel_amount, cancel_reason: @payment.cancel_reason, cancelled_at: @payment.cancelled_at, fail_reason: @payment.fail_reason, failed_at: @payment.failed_at, imp_uid: @payment.imp_uid, merchant_uid: @payment.merchant_uid, name: @payment.name, paid_at: @payment.paid_at, pay_method: @payment.pay_method, pg_provider: @payment.pg_provider, pg_tid: @payment.pg_tid, status: @payment.status, user_id: @payment.user_id } }
    end

    assert_redirected_to payment_url(Payment.last)
  end

  test "should show payment" do
    get payment_url(@payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_url(@payment)
    assert_response :success
  end

  test "should update payment" do
    patch payment_url(@payment), params: { payment: { amount: @payment.amount, cancel_amount: @payment.cancel_amount, cancel_reason: @payment.cancel_reason, cancelled_at: @payment.cancelled_at, fail_reason: @payment.fail_reason, failed_at: @payment.failed_at, imp_uid: @payment.imp_uid, merchant_uid: @payment.merchant_uid, name: @payment.name, paid_at: @payment.paid_at, pay_method: @payment.pay_method, pg_provider: @payment.pg_provider, pg_tid: @payment.pg_tid, status: @payment.status, user_id: @payment.user_id } }
    assert_redirected_to payment_url(@payment)
  end

  test "should destroy payment" do
    assert_difference('Payment.count', -1) do
      delete payment_url(@payment)
    end

    assert_redirected_to payments_url
  end
end
