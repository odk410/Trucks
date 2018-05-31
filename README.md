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
모르겠다면 기본적으로 무소속 데이터가 있으니 그것으로 설정하도록 하자.
---
Wiki의 user를 references로 생성하면 FK관계가 설정되고 index가 생성된다. -> User 데이터를 삭제하려할 때 문제가 됨
회원탈퇴 시 해당 유저가 작성한 Wiki를 전부 삭제해야 한다.

그래서 user를 references로 생성하지 않고 integer로 생성하여 연관된 작업을 할 수 없도록 하였다.

Wiki를 작성한 유저가 회원탈퇴 시 Wiki의 작성자는 nil이 됨
---
회원탈퇴 시 바로 User테이블에서 레코드를 지워버리는 강한 삭제보다
Soft destroy(delete)를 하는 게 좋아보인다. 아직 작업 하진 않음
Soft destroy를 적용하려면 devise의 컨트롤러를 재정의 해야한다.
User 모델에 deleted_at을 생성하여 탈퇴한 시간을 기록한다.
탈퇴한 email로는 당분간 가입이 불가능하다.
며칠 전에 탈퇴를 철회할 수 있다.

며칠이 지난 후, 레코드를 삭제하며, 그 이후엔 가입이 가능.
자동으로 되어야하지만.. 잘 모르겠으니 expired 속성을 두어 관리자가 유저 정보를 갱신하였을 때
true로 만들고 그것들을 삭제하자 언제?ㅠㅠ
---
계좌 테이블
rails g model Account acc_num master:references{polymorphic} balance:integer
서비스 내 유저, 셀럽, DP가 같은 형식의 Account를 갖도록 하기 위해 master:references{polymorphic}으로 구현
거래기록 테이블
rails g model AccountLog account:references amount:integer balance:integer send:boolean receive:boolean target_acc
rails g model Transaction host_acc amount:integer balance:integer send:boolean receive:boolean target_acc

rails g model Transaction account:references amount:integer balance:integer remit:boolean receive:boolean target

Send 예약어다 시1!!!발... ㅠㅜㅠㅠㅠㅠㅠㅠ
어느계좌가 얼마를 어느계좌에/로부터 보냈다/받았다. 그리고 현재시점의 잔액은 얼마.

rails db:migrate
---
Payments에는 다음과 같은 항목이 있음
https://docs.iamport.kr/tech/imp#param
imp_uid     ->  iamport 결제시도 시 부여됨
pg_provider -> paypal or inicis or...
amount    -> 금액   (KRW,USD,EUR,JPY가 있지만 Paypal은 USD만)
name      -> 뭐사는지 16자  이내 권장
pay_method  ->  card or...
status  -> 결제 진행상태
merchant_uid  -> 상품아이디 (우리가 부여)
user  -> 주문자

cancel_reason
cancelled_at
cancel_amount
paid_at
fail_reason
failed_at

그렇다면... pg_provider



ArgumentError: Unknown key: :as. Valid keys are: :class_name, :anonymous_class, :foreign_key, :validate, :autosave, :foreign_type, :dependent, :primary_key, :inverse_of, :required, :polymorphic, :touch, :counter_cache, :optional, :default

----
Account와 Transaction 테스트(seed)
셀럽의 view에서 거래 기록 파악, 내 정보에서 거래 기록 파악 (get 'transactions/account_inquiry')
404페이지 작업(현재 주석으로 비활성화)
UtilityHelper 작성. 현재 인수를 콘솔에 출력해주는 메소드를 작성해놓음
팝업으로 결제할 수 있도록  팝업 링크 생성, 팝업창 띄우고 현재 Payment를 생성하는 폼이 뜸
https://jtway.co/5-steps-to-add-remote-modals-to-your-rails-app-8c21213b4d0c
위 작업을 하다가. Payment에는 Product(polymorphic) 으로 무엇을 위해 구매하는 지 기록해야 할 것 같음.
ex)
Event 응모권을 구매하는 것이라면
product_type: "Event"
product_id: '23'

Goods를 구매하는 것이라면
product_type: "Goods"
proudct_id: "1"  이런식..
