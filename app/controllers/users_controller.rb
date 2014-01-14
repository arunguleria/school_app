class UsersController < ApplicationController
  
  before_action :check_no_login, only: [:signup, :signin]
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def check_no_login
    if current_user
      redirect_to teachers_path, alert: "you are already logged in"
    end
  end

  public
  
  def signup
    if request.get?
      @user = User.new
    elsif request.post?
      @user = User.new(user_params)
      if @user.save
        redirect_to signin_url, notice: "Your accout has ben created.please logged in to continue"
      else
        flash[:alert] = "Please provide correct information and try again"
      end
    end
  end
  
  
  def signin
    if request.post?
      @user = User.authenticate(user_params)
      if @user.is_a?(User)
        session[:current_user] = @user
        redirect_to teachers_path, notice: "you have successfully logged in "
      else
        flash[:alert] = "Sorry invalid email and password! try again"
      end
    end
  end
  
  
  def logout
    reset_session
    redirect_to signin_url, notice: "you have successfully logged out"
  end
  
end
