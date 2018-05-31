class RegisterController < ApplicationController
  before_action :set_user, only: [:info, :registration, :registraion_email]
  def info
  end

  def registration
  end

  def registraion_email
    email = User.find_by(email: params[:user][:email])
    if email.nil?
      @user.update(email: params[:user][:email])
      @user.save
      redirect_to root_path
    else
      flash[:warning] = '이미 존재하는 아이디입니다.'
      redirect_back(fallback_location: register_registraion_email_path)
    end
  end

  private
  def set_user
    @user = current_user
  end
end
