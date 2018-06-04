class Identity < ApplicationRecord
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    #sns로부터 가져온 정보를 토대로 정보를 찾는다.
    #만약 가져온 정보가 있다면 해당 정보를 찾고
    #정보가 없다면 생성한다.
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end
end
