class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :account, foreign_key: true
      t.integer :amount
      t.integer :balance
      t.boolean :remit
      t.boolean :receive
      t.string :target

      t.timestamps
    end
  end
end
