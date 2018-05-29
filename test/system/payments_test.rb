require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase
  setup do
    @payment = payments(:one)
  end

  test "visiting the index" do
    visit payments_url
    assert_selector "h1", text: "Payments"
  end

  test "creating a Payment" do
    visit payments_url
    click_on "New Payment"

    fill_in "Amount", with: @payment.amount
    fill_in "Cancel Amount", with: @payment.cancel_amount
    fill_in "Cancel Reason", with: @payment.cancel_reason
    fill_in "Cancelled At", with: @payment.cancelled_at
    fill_in "Fail Reason", with: @payment.fail_reason
    fill_in "Failed At", with: @payment.failed_at
    fill_in "Imp Uid", with: @payment.imp_uid
    fill_in "Merchant Uid", with: @payment.merchant_uid
    fill_in "Name", with: @payment.name
    fill_in "Paid At", with: @payment.paid_at
    fill_in "Pay Method", with: @payment.pay_method
    fill_in "Pg Provider", with: @payment.pg_provider
    fill_in "Pg Tid", with: @payment.pg_tid
    fill_in "Status", with: @payment.status
    fill_in "User", with: @payment.user_id
    click_on "Create Payment"

    assert_text "Payment was successfully created"
    click_on "Back"
  end

  test "updating a Payment" do
    visit payments_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @payment.amount
    fill_in "Cancel Amount", with: @payment.cancel_amount
    fill_in "Cancel Reason", with: @payment.cancel_reason
    fill_in "Cancelled At", with: @payment.cancelled_at
    fill_in "Fail Reason", with: @payment.fail_reason
    fill_in "Failed At", with: @payment.failed_at
    fill_in "Imp Uid", with: @payment.imp_uid
    fill_in "Merchant Uid", with: @payment.merchant_uid
    fill_in "Name", with: @payment.name
    fill_in "Paid At", with: @payment.paid_at
    fill_in "Pay Method", with: @payment.pay_method
    fill_in "Pg Provider", with: @payment.pg_provider
    fill_in "Pg Tid", with: @payment.pg_tid
    fill_in "Status", with: @payment.status
    fill_in "User", with: @payment.user_id
    click_on "Update Payment"

    assert_text "Payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Payment" do
    visit payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payment was successfully destroyed"
  end
end
