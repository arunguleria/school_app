class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def current_user
    session[:current_user]
  end
  
  
  private
  
  def login_check
    unless current_user
      redirect_to signin_url, alert: "please login to continue"
    end
  end
  
end
