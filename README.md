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
  
  
shared의 _nav에 로그인과 회원가입이 있어서 그 부분을 다음과 같이 수정하였음
```ruby
        <div class="tab-content">
          <%-# Login form -%>
          <%= render "devise/sessions/new" %>
          <%-# SignUp form -%>
          <%= render "devise/registrations/new" %>
        </div>
```
각 각의 view에 가보면 구현 상황을 알 수 있음.


Celebrity - Single Item Page
