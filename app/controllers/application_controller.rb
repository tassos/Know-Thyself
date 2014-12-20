class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :count_surveys
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors
  
  def count_surveys
    if current_user.present?
      @survey_count = Survey.find(:all, :conditions => ["user_id = ?", current_user.id]).count
    end
  end
  
  protected

  def show_errors(exception)
    message = ""
    if exception.to_s == "Validation failed: Email has already been taken"
      message = "The e-mail you have chosen belongs to a registered user. Please choose another one or login with your account"
    end
    flash[:alert] = message
    redirect_to root_path
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :name) }
  end
end
