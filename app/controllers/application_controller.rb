class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  helper_method :resource_name, :resource, :devise_mapping, :resource_class
  before_action :configure_permitted_parameters, if: :devise_controller?

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
# 404, 500 에러페이지 활성화
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404
  # rescue_from Exception, with: :render_500

  # def render_404
  #   render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  # end
  #
  # def render_500
  #   render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  # end
  def respond_modal_with(*args, &blk)
    UtilityHelper::printArgs(args)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :addr, :tel, :postcode, :profile_img])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :addr, :tel, :postcode, :email, :profile_img])
  end
end
