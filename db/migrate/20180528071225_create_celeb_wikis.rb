class CreateCelebWikis < ActiveRecord::Migration[5.2]
  def change
    create_table :celeb_wikis do |t|
      t.references :celebrity, foreign_key: true
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
