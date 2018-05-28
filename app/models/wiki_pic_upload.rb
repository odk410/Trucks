class WikiPicUpload < ApplicationRecord
  mount_uploaders :wiki_pics, WikiPicUploader
  serialize :wiki_pics, JSON # If you use SQLite, add this line
end
