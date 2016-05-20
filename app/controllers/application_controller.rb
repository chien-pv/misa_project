class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception

  layout :check_layout

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  protected

  def check_layout
    if devise_controller? && resource_name == :user && action_name == "new"
      "layout_for_devise"
    else
      "application"
    end
  end

  def configure_permitted_parameters      
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end
end
