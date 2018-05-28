class Celebrity < ApplicationRecord
  belongs_to :company
  belongs_to :group
  has_many :celeb_wikis, :dependent => :destroy
end
