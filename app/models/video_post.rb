class VideoPost < ApplicationRecord
  mount_uploader :video, VideoUploader
end
