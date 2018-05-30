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
