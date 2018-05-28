class CelebWiki < ApplicationRecord
  belongs_to :user
  belongs_to :celebrity
end
