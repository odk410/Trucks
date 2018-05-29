class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :acc_num
      t.references :master, polymorphic: true
      t.integer :balance

      t.timestamps
    end
  end
end
