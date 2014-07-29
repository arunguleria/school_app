require 'test_helper'

class LockersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  
  test "should fetch locker" do
    login_as(:one)
    teacher = teachers(:one)
    get :show, teacher_id: teacher.id
    assert_response :success
  end
  
  test "should not create a new locker with invalid/incomplete data" do
    login_as(:one)
    teacher = teachers(:one)
    assert_no_difference("Locker.count") do
      post :create, teacher_id: teacher.id, locker: {locker_number: "L22", compartment: "C"}
    end
    assert assigns(:locker)
    assert_response :success
    assert_equal "please correctly fill the fields", flash[:alert] 
  end
  
  test "should create a new locker" do
    login_as(:one)
    teacher = teachers(:three) # this user doesn't have a locker yet.
    assert_difference("Locker.count") do
      post :create, teacher_id: teacher.id, locker: {locker_number: "L22", compartment: "C"}
    end
    assert assigns(:teacher)
    assert assigns(:locker)
    assert_response :redirect
    assert_redirected_to teacher_locker_path(teacher_id: assigns(:teacher)) 
  end
  
  test "should render the edit page" do
    login_as(:one)
    teacher = teachers(:one)
    locker = teacher.locker
    get :edit, teacher_id: teacher.id, id: locker.id
    assert_response :success
  end
  
  test "should update an existing locker" do
    login_as(:one)
    teacher = teachers(:one)
    locker = teacher.locker
    assert_no_difference("Locker.count") do
      put :update, teacher_id: teacher.id, id: locker.id, locker: {locker_number: "L22", compartment: "C"}
    end
    assert assigns(:teacher)
    assert assigns(:locker)
    assert_response :redirect
    assert_redirected_to teacher_locker_path(teacher_id: assigns(:teacher))
    assert_equal "Successfully updated", flash[:notice]
  end
  
  test "should destroy a locker and redirect to index page" do
    login_as(:one)
    teacher = teachers(:one)
    locker = teacher.locker
    assert_difference("Locker.count", -1) do
      delete :destroy, teacher_id: teacher.id, id: locker.id
    end
    assert assigns(:teacher)
    assert_response :redirect
    assert_redirected_to teacher_path(assigns(:teacher))
    assert_equal "Successfully deleted the locker", flash[:notice] 
  end

end
