# sns_login
>google, kakao, line 연동
>
>지금은 개인 계정 KEY로 진행 차후 회사 아이디 계정으로 발급받은 KEY로 변경

## Gem 설치
```ruby
# sns 관리자 ID, KEY보안에 사용
gem 'figaro'
# sns_login gem
gem 'omniauth-google-oauth2'
gem 'omniauth-kakao', :git => 'git://github.com/hcn1519/omniauth-kakao'
gem 'omniauth-line'
```

- figaro 설치 : `$ bundle exec figaro install` -> `.gitignore`, `config/application.yml` 파일이 생성 이곳에서 보여주고 싶지 않은 값을 설정하면 된다.

- figaro 문서 : https://github.com/laserlemon/figaro

- 사용법

  ```ruby
  # config/application.yml

  pusher_app_id: "2954"
  pusher_key: "7381a978f7dd7f9a1117"
  pusher_secret: "abdc3b896a0ffb85d373"

  # config/initializers/pusher.rb
  # config/application.yml에서 설정한 값을 ENV로 불러와서 사용
  Pusher.app_id = ENV["pusher_app_id"]
  Pusher.key    = ENV["pusher_key"]
  Pusher.secret = ENV["pusher_secret"]
  ```



## SNS Developer

> 각 SNS Developer에서 ID, KEY 발급 받기
>
> 카카오의 경우  ID만 제공해준다.
>
> Token으로 정보를 가져 올 때  SNS email 존재 유무
>
> - email 제공 : google
> - email 제공 안 함 : kakao, line, twitter

- 구글 로그인 : https://github.com/zquestz/omniauth-google-oauth2

- 구글 Developers : https://console.developers.google.com/cloud-resource-manager (라이브러리 : people api, google+ api 설치)

- 카카오 로그인 : https://github.com/shaynekang/omniauth-kakao

- 카카오 Developers : https://developers.kakao.com/

- Line 로그인 : https://github.com/kazasiki/omniauth-line

- Line Developers : https://developers.line.me/en/

- 트위터 로그인 : https://github.com/arunagw/omniauth-twitter

- 트위터 Developers : https://apps.twitter.com/

  > 참고사항
  >
  > 트위터는 http://localhost:3000 이 안된다.
  >
  > 때문에 http://127.0.0.1:3000을 사용해야 한다.

## SNS Login할 때 추가 정보를 처리할 Controller 추가

> SNS로 회원가입 할 때 필수입력 값을 추가적으로 처리하기 위한 Controller
>
> Email이 없는 SNS의 경우 Email을 입력받아 회원가입 시킨다.

​	`rails g controller register info registration registraion_email`

- `registration` : email을 제공해주는 sns 처리
- `registration_email` : email을 제공해주지 않는 sns처리



​	`rails g devise:controllers user`

- omniauth callback 처리를 위해 사용
- 생성된 파일들 중 `omniauth_callbacks_controller.rb`를 사용

## 여러 SNS 경로를 통해 회원가입을 하기 때문에 각 소셜 로그인 정보를 저장할 DB(identity) 생성

​	`rails g model identity user:references provider:string uid:string`

- user : FK
- provider : SNS 이름
- uid : 회원 고유번호

## Config 설정

> 만든 모델과 컨트롤러가 작동하도록 만들기 위해 config 수정

```ruby
# config\routes.rb

# callback 처리를 위한 경로 설정
  devise_for :users, :controllers => { :omniauth_callbacks => 'user/omniauth_callbacks' }
```

```ruby
# config\initializers\devise.rb

# omniauth 사용할 sns의 id, key 등록
# id, key값은 노출되면 안되기 때문에 Figaro를 사용
  config.omniauth :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
# 카카오의 경우 OAuth 인증을 이용할 경우 Redirect할 경로를 적어 주어야 함
# 참고 : https://developers.kakao.com
  config.omniauth :kakao, ENV["KAKAO_CLIENT_ID"], :redirect_path => "/users/auth/kakao/callback"
  config.omniauth :line, ENV["LINE_CLIENT_ID"], ENV["LINE_CLIENT_SECRET"]
```

```ruby
   # config/application.yml

   # Google
   GOOGLE_CLIENT_ID: "발급받은 KEY 값"
   GOOGLE_CLIENT_SECRET: "발급받은 KEY 값"

   #Kakao
   KAKAO_CLIENT_ID: "발급받은 KEY 값"

   # Line
   LINE_CLIENT_ID: "발급받은 KEY 값"
   LINE_CLIENT_SECRET: "발급받은 KEY 값"
```



## Model 설정

```ruby
# app/models/user.rb

# devise에서 omniauth사용을 위해 :omniauthable 추가
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :celeb_wiki

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
```

```ruby
# app/models/identity.rb
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
```



## Controller 설정

```ruby
# app\controllers\members\omniauth_callbacks_controller.rb

# frozen_string_literal: true

class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
      class_eval %Q{
        def #{provider}
          @user = User.find_for_oauth(request.env["omniauth.auth"])
          if @user.persisted?
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
          else
            session["devise.#{provider}_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_path
          end
        end
      }
  end

  [:twitter, :line, :kakao, :google_oauth2].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
      # root_path
    auth = request.env['omniauth.auth']
    @identity = Identity.find_for_oauth(auth)
    @user =  User.find(current_user.id)

    if @user.persisted?
      if @user.email == ""
        if @identity.provider == "kakao" || @identity.provider == "line" || @identity.provider == "twitter"
          register_info_path
        end
      else
        root_path
      end
    else
      root_path
    end
  end
end
```



## View 설정

- 로그인 링크 설정

  구글 : `user_google_oauth2_omniauth_authorize_path`

  카카오 : `user_kakao_omniauth_authorize_path`

  라인 : `user_line_omniauth_authorize_path`


```html
<!-- app\views\devise\registrations\_new.html.erb -->

<!-- 기존 로그인 버튼을 아래와 같이 변경 -->
	<a class="media-btn media-facebook" href="#"><i class="socicon-facebook"></i><span>Signup with Facebook</span></a>
    <%= link_to user_google_oauth2_omniauth_authorize_path, :class => "media-btn media-google" do %> <i class="socicon-googleplus"></i><span>Signup with Google+</span> <%end%>
    <%= link_to user_twitter_omniauth_authorize_path, :class => "media-btn media-twitter" do %> <i class="socicon-twitter"></i><span>Signup with Twitter</span> <%end%>
    <%= link_to user_line_omniauth_authorize_path, :class => "media-btn media-line" do %> <i class="fab fa-line"></i><span>Signup with Line</span> <%end%>
    <%= link_to user_kakao_omniauth_authorize_path, :class => "media-btn media-kakao" do %> <i><%= image_tag "kakaolink_btn_small.png", size: "20"%></i><span style="color: #4d3031;font-weight:550">Signup with Kakao</span> <%end%>
```

```html
<!-- app\views\register\info.html.erb -->

<!-- profile_img가 비어있다면 default이미지를 비어있지 않다면 sns에서 받아온 image를 보여준다. -->
<div class="user-info">
          <div class="user-avatar">
            <%= image_tag("account/user.png", alt: "User") if current_user.profile_img.blank? %>
            <%= image_tag(current_user.profile_img, alt: "User") unless current_user.profile_img.blank? %>
          </div>
          <div class="user-data">
            <h5><%= resource.name %></h5><span>Joined <%=resource.try(:created_at).try(:strftime,("%B %d, %Y"))%></span>
            <!-- February 06, 2017 -->
          </div>
        </div>
```
