class CreateVideoPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :video_posts do |t|
      t.string :title
      t.text :content
      t.string :video
      t.integer :video_location

      t.timestamps
    end
  end
end
