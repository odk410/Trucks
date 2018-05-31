class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :create_user_account

  # 회원탈퇴 시 작성한 wiki 다 삭제 됨.
  # has_many :celeb_wikis, dependent: :destroy
  has_many :celeb_wikis
  has_one :account, :as => :master, :dependent => :destroy

  # def create_account
  #   # rails g model Account acc_num master:references{polymorphic} balance:integer
  #
  #   # 이 밑으로 Helper로 뺄 것. Celebrity와 DP 역시 아래와 같이 작업하기 때문에..
  #   create_account('User', self.id)
  # end

  def create_user_account
    User.create_account('User', self.id)
  end
end
