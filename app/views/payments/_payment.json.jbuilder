json.extract! payment, :id, :imp_uid, :pg_provider, :amount, :name, :pay_method, :status, :merchant_uid, :user_id, :cancel_reason, :cancelled_at, :cancel_amount, :paid_at, :fail_reason, :failed_at, :pg_tid, :created_at, :updated_at
json.url payment_url(payment, format: :json)
