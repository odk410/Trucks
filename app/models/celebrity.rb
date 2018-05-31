class Celebrity < ApplicationRecord
  after_create :create_celeb_account

  belongs_to :company, optional: true
  belongs_to :group, optional: true
  has_many :celeb_wikis
  has_one :account, :as => :master, :dependent => :destroy  

  # def create_account
  #   # rails g model Account acc_num master:references{polymorphic} balance:integer
  #
  #   # 이 밑으로 Helper로 뺄 것. Celebrity와 DP 역시 아래와 같이 작업하기 때문에..
  #   create_account('Celebrity', self.id)
  # end
  def create_celeb_account
    Celebrity.create_account('Celebrity', self.id)
  end
end
