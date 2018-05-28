class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :company, foreign_key: true
      t.integer :num_member

      t.timestamps
    end
  end
end
