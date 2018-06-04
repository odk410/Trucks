class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  after_create :create_user_account

  # 회원탈퇴 시 작성한 wiki 다 삭제 됨.
  # has_many :celeb_wikis, dependent: :destroy
  has_many :celeb_wikis
  has_one :account, :as => :master, :dependent => :destroy
  mount_uploader :profile_img, ImageUploader

  # def create_account
  #   # rails g model Account acc_num master:references{polymorphic} balance:integer
  #
  #   # 이 밑으로 Helper로 뺄 것. Celebrity와 DP 역시 아래와 같이 작업하기 때문에..
  #   create_account('User', self.id)
  # end

  def create_user_account
    User.create_account('User', self.id)
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # user와 identity가 nil이 아니라면 받는다
    identity = Identity.find_for_oauth(auth)

    #조건부(삼항) 연산자
    #signed_in_resource 의 boolean에 따라 true면 signed_in_resource, false면 identity.user가 반환
    user = signed_in_resource ? signed_in_resource : identity.user

    # user가 nil이라면 새로 만든다.
    if user.nil?

      # 이미 있는 이메일인지 확인한다.
      email = auth.info.email
      user = User.where(:email => email).first
      unless self.where(email: auth.info.email).exists?

        # 없다면 새로운 데이터를 생성한다.
        if user.nil?
          # Kakao는 email을 제공하지 않기 때문에 따로 처리해야한다.
          if auth.provider == "kakao" || auth.provider == "line" || auth.provider == "twitter"

            user = User.new(
              name: auth.info.name,
              profile_img: auth.info.image,
              password: Devise.friendly_token[0,20]
            )

          else
            user = User.new(
              name: auth.info.name,
              email: auth.info.email,
              profile_img: auth.info.image,
              password: Devise.friendly_token[0,20]
            )
          end

          user.save!
        end

      end

    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user

  end

  def email_changed?
    false
  end

  # 원래 devise는 email 입력이 필수
  # 하지만 sns인증 후 email을 제공하지 않는 경우를 위해
  # email이 없어도 가입이 되도록 설정
  def email_required?
    false
  end
end
