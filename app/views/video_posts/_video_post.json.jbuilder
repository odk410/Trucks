json.extract! video_post, :id, :title, :content, :video, :video_location, :created_at, :updated_at
json.url video_post_url(video_post, format: :json)
