require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should get signin" do
    get :signin
    assert_response :success
  end
  
  test "signup to create account"do
    assert_difference('User.count') do
      post :signup, user:  {name: 'test', 
              email: 'test@gmail.com', 
              password: 'qwe123', 
              password_confirmation: 'qwe123'}
    end
    assert_response :redirect
    assert_redirected_to signin_path
    assert_equal "Your accout has ben created.please logged in to continue", flash[:notice] 
  end
  
  test "signup to create an account with invalid data"do
    assert_no_difference('User.count') do
      post :signup, user:  {name: 'test', 
              email: 'test@gmail.com', 
              password: 'qwe123', 
              password_confirmation: 'qwe12'}
    end
    assert_response :success
    assert_equal "Please provide correct information and try again", flash[:alert]
  end
  
  test "should signin with valid data" do
    user = users(:one)
    post :signin, user: {email: user.email, password: 'password1234'}
    assert_equal session[:current_user], user
    assert_equal 'You have successfully logged in.', flash[:notice]
    assert_response :redirect
    assert_redirected_to teachers_path
  end
  
  test "should signin with invalid data" do
    user = users(:one)
    post :signin, user: {email: user.email, password: 'password12'}
    assert_response :success
    assert_equal 'Invalid email or password. Please try again!', flash[:alert]
    
    
  end
end
