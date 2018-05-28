class CreateCelebrities < ActiveRecord::Migration[5.2]
  def change
    create_table :celebrities do |t|
      t.string :name, null: false
      t.references :company, foreign_key: true
      t.references :group, foreign_key: true
      t.string :category, null: false, default: ""
      t.string :color, null: false, default: ""

      t.timestamps
    end
  end
end
