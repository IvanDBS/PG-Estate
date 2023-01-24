class ApplicationController < ActionController::Base
  
  include Pagy::Backend

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?  
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:fullname, :phone, :email, :password, :avatar)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:fullname, :phone, :avatar, :email, :password, :current_password)}
  end
end
