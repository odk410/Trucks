class Celebrity < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :group, optional: true
  has_many :celeb_wikis
end
