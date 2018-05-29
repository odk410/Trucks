class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :create_account

  # 회원탈퇴 시 작성한 wiki 다 삭제 됨.
  # has_many :celeb_wikis, dependent: :destroy
  has_one :account, :as => :master, :dependent => :destroy

  def create_account
    # rails g model Account acc_num master:references{polymorphic} balance:integer

    # 이 밑으로 Helper로 뺄 것. Celebrity와 DP 역시 아래와 같이 작업하기 때문에..
    random_str = ('a'..'z').to_a.shuffle[0,14].join
    @account = Account.new(acc_num: random_str,
      master_type: 'User',
      master_id: self.id,
      balance: 0)
    @account.save

    puts "/"*50
    puts random_str
    puts @account
    puts @account.master_type
    puts @account.master_id
    puts "/"*50
  end
end
