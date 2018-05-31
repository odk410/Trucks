class Account < ApplicationRecord
  belongs_to :master, polymorphic: true
  # 계좌 소멸시 거래기록 소멸
  has_many :transactions, dependent: :destroy
end
