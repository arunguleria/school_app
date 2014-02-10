require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    
  test "should fetch tasks" do
    login_as(:one)
    teacher = teachers(:one)
    get :index, id: teacher.tasks
    assert_response :success
  end
  
    
  
end
