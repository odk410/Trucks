class AddWikiPicsToWikiPicUpload < ActiveRecord::Migration[5.2]
  def change
    add_column :wiki_pic_uploads, :wiki_pics, :string
  end
end
