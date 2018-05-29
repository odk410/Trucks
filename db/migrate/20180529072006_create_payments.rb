class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :imp_uid
      t.string :pg_provider
      t.integer :amount
      t.string :name
      t.string :pay_method
      t.string :status
      t.string :merchant_uid
      t.references :user, foreign_key: true
      t.string :cancel_reason
      t.integer :cancelled_at
      t.integer :cancel_amount
      t.integer :paid_at
      t.string :fail_reason
      t.integer :failed_at
      t.string :pg_tid

      t.timestamps
    end
  end
end
