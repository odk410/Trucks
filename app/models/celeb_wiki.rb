class CelebWiki < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :celebrity
end
