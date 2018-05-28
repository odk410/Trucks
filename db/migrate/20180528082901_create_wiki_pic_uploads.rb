class CreateWikiPicUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :wiki_pic_uploads do |t|

      t.timestamps
    end
  end
end
