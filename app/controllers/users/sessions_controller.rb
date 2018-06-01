# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @continue = params[:continue]
    super
    # UtilityHelper::printArgs(params[:continue], "new")
  end

  # POST /resource/sign_in
  def create
    super
    # UtilityHelper::printArgs(params[:user][:continue], "create")
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    unless params[:user][:continue].nil?
      params[:user][:continue]
    else
      root_path
    end
  end
end
