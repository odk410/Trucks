class Account < ApplicationRecord
  belongs_to :master, polymorphic: true
end
