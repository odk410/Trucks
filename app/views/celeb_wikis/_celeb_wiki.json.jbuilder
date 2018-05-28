json.extract! celeb_wiki, :id, :user_id, :celebrity_id, :content, :created_at, :updated_at
json.url celeb_wiki_url(celeb_wiki, format: :json)
