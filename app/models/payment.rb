class Payment < ApplicationRecord
  # belongs_to :product, polymorphic: true  
  belongs_to :user
end
