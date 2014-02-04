require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    
  test "should fetch tasks" do
    login_as(:one)
    teacher = teachers(:one)
    get :teacher_tasks_url(teacher)
    assert_response :success
  end
  
    
  
end
