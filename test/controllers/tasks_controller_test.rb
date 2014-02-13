require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
      
  test "should fetch tasks" do
    login_as(:one)
    teacher = teachers(:one)
    get :index, teacher_id: teacher.id
    assert_response :success
  end
  
  test "should not create a new task with invalid/incomplete data" do
    login_as(:one)
    teacher = teachers(:one)
    assert_no_difference("teacher.tasks.count") do
      post :create, teacher_id: teacher.id, task: {title: "Annual Function", description: "ready the schedule for annual function"}

    end
    assert assigns(:task)
    assert_response :success
    assert_equal "please correctly fill the fields", flash[:alert] 
  end
  
  test "should create a new task" do
    login_as(:one)
    teacher = teachers(:one)
    assert_difference("teacher.tasks.count") do
      post :create, teacher_id: teacher.id, task: {title: "Annual Function", description: "ready the schedule for annual function", priority: Task::PRIORITIES.first}
    end
    assert assigns(:teacher)
    assert assigns(:task)
    assert_response :redirect
    assert_redirected_to teacher_task_path(teacher_id: assigns(:teacher), id: assigns(:task)) 
  end
  
  test "should render the edit page" do
    login_as(:one)
    teacher = teachers(:one)
    task = teacher.tasks.first
    get :edit, teacher_id: teacher.id, id: task.id
    assert_response :success
  end
   
   test "should update an existing task" do
    login_as(:one)
    teacher = teachers(:one)
    task = teacher.tasks.first
    assert_no_difference("teacher.tasks.count") do
      put :update, teacher_id: teacher.id, id: task.id, task: {title: "Function", description: "ready the schedule for annual function", priority: Task::PRIORITIES.last}
    end
    assert assigns(:teacher)
    assert assigns(:task)
    assert_response :redirect
    assert_redirected_to teacher_task_path(teacher_id: assigns(:teacher), id: assigns(:task))
    assert_equal "Successfully updated", flash[:notice]
  end
  
  test "should destroy a task and redirect to index page" do
    login_as(:one)
    teacher = teachers(:one)
    task = teacher.tasks.first
    assert_difference("teacher.tasks.count", -1) do
      delete :destroy, teacher_id: teacher.id, id: task.id
    end
    assert_response :redirect
    assert_redirected_to teacher_tasks_path
    assert_equal "Successfully deleted the task", flash[:notice] 
  end
  
  
end
