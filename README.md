# Unishop Version2


[사이트정보](https://wrapbootstrap.com/theme/unishop-universal-e-commerce-template-WB0148688)

[미리보기](http://themes.rokaux.com/unishop/v3.0/template-2/docs/dev-setup.html)


rails generate simple_form:install

gem 'devise'
rails g devise:install
   in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
in application.html.erb   
    <p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>


rails g devise:views

rails generate devise User

rails db:migrate

Login 작업
simple_form의 resource를 사용할 수 있도록 하기 위해
ApplicationController에 다음과 같이 작성
```ruby
class ApplicationController < ActionController::Base
  helper_method :resource_name, :resource, :devise_mapping, :resource_class
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
```


simple_form의 input에 required: true를 활성화 하려면
config/initializers/simple_form.rb에
  config.browser_validations = true 해야함.


shared의 nav에 로그인과 회원가입이 있어서 그 부분을 다음과 같이 수정하였음
```ruby
        <div class="tab-content">
          <%-# Login form -%>
          <%= render "devise/sessions/new" %>
          <%-# SignUp form -%>
          <%= render "devise/registrations/new" %>
        </div>
```
각 각의 view에 가보면 구현 상황을 알 수 있음.
---
Devise 속성 추가
rails g migration add_info_to_users tel name addr postcode profile_img verified:boolean celeb_verified:boolean

Devise에 추가한 속성을 인식시키기 위해 application_controller에 devise_parameter_sanitizer 작업.
---
Celebrity 데이터를 추가하기 위해서는 선행적으로 해당 셀러브리티가 어느 회사의 소속인지, 어느 그룹의 소속인지를 정해주어야 한다.
모르겠다면 기본적으로 무소속 데이터가 있으니 그것으로 설정하도록 하자.\
----
계좌 테이블
rails g model Account acc_num master:references{polymorphic} balance:integer
서비스 내 유저, 셀럽, DP가 같은 형식의 Account를 갖도록 하기 위해 master:references{polymorphic}으로 구현
거래기록 테이블
rails g model Transaction account:references amount:integer balance:integer send:boolean receive:boolean to_acc_num
어느계좌가 얼마를 어느계좌에/로부터 보냈다/받았다. 그리고 현재시점의 잔액은 얼마.

rails db:migrate
