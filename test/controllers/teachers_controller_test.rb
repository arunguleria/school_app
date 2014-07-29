require 'test_helper'

class TeachersControllerTest < ActionController::TestCase
  
  test "should be redirected if not logged in" do
    get :index
    assert_response :redirect
  end
  
  test "should fetch teachers" do
    login_as(:one)
    get :index
    assert_response :success
  end
  
  test "should fetch a single teacher" do
    login_as(:one)
    teacher = teachers(:one)
    get :show, id: teacher.id
    assert_response :success
  end
  
  test "should render the new page" do
    login_as(:one)
    get :new
    assert_response :success
  end
  
  test "should not create a new teacher with invalid/incomplete data" do
    login_as(:one)
    assert_no_difference("Teacher.count") do
      post :create, teacher: {first_name: 'New Teacher'}
    end
    assert assigns(:teacher)
    assert_response :success
    assert_equal "Please correctly fill the form", flash[:alert] 
  end
  
  test "should create a new teacher" do
    login_as(:one)
    assert_difference("Teacher.count") do
      post :create, teacher: {first_name: 'New Teacher', last_name: 'Sharma', email: 'new_teacher@gmail.com'}
    end
    assert assigns(:teacher)
    assert_response :redirect
    assert_redirected_to teacher_path(assigns(:teacher))
    assert_equal "Successfully created teacher.", flash[:notice] 
  end
  
  test "should render the edit page" do
    login_as(:one)
    teacher = teachers(:one)
    get :edit, id: teacher.id
    assert_response :success
  end
 
  test "should update an existing teacher" do
    login_as(:one)
    assert_no_difference("Teacher.count") do
      put :update, :id => teachers(:one), teacher: {first_name: 'New Teacher', last_name: 'Thakur',
       email: 'new_teacher@gmail.com'}
    end
    assert assigns(:teacher)
    assert_response :redirect
    assert_redirected_to teacher_path(assigns(:teacher))
    assert_equal "Successfully updated teacher.", flash[:notice]
  end
  
  test "should destroy a teacher and redirect to index page" do
    login_as(:one)
    teacher = teachers(:one)
    assert_difference("Teacher.count", -1) do
      delete :destroy, id: teacher.id
    end
    assert_response :redirect
    assert_redirected_to teachers_path
    assert_equal "Successfully deleted the teacher", flash[:notice] 
  end
  
end

