require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
    
  fixtures :users, :teachers, :lockers, :tasks, :attachments
    
  test "login browse and logout the site" do
  
    get "/"    
    assert_response :redirect
    assert_redirected_to signin_path
    follow_redirect!
    assert_equal "Please login to continue!", flash[:alert] 
    user = users(:one)
    
    # test with incorrect/invalid password
    post signin_path, user: {email: user.email, password: 'Invalid Password'}
    assert_response :success
    assert_equal 'Invalid email or password. Please try again!', flash[:alert]
    
    post_via_redirect signin_path, user: {email: user.email, password: 'password1234'}
    assert_equal 'You have successfully logged in.', flash[:notice]
    assert assigns(:teachers)
  
    get teacher_path(id: 1)
    assert_response :success
    
    get teacher_tasks_path(teacher_id: 1)
    assert_response :success
    
    
    # TODO: test all the associated controllers here
    # create a new task
    teacher = teachers(:one)
    tasks_count = teacher.tasks.count
    post_via_redirect teacher_tasks_path(teacher_id: teacher.id), task: {title: "integration testing", description: "testing", priority: Task::PRIORITIES.first}
    assert_equal tasks_count+1, teacher.tasks.count
    assert assigns(:teacher)
    assert assigns(:task)
    assert_response :success
    
    # update task
    tasks_count = teacher.tasks.count
    assert_no_difference("teacher.tasks.count") do
      put_via_redirect teacher_task_path(teacher_id: teacher.id), task: {title: "integration testing", description: "testing", priority: Task::PRIORITIES.last}
    end
    assert_equal tasks_count, teacher.tasks.count
    assert assigns(:teacher)
    assert assigns(:task)
    assert_response :success
    
    #delete task
    task = teacher.tasks.first
    assert_difference("teacher.tasks.count", -1) do
      delete_via_redirect teacher_task_path(teacher_id: teacher.id),  id: task.id
    end
    assert_response :success
    assert_equal "Successfully deleted the task", flash[:notice]

    
    #create new attachment
    attachment_count = teacher.attachments.count
    test_file = Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/logo.jpg'), 'image/jpg')
    post_via_redirect teacher_attachments_path(teacher_id: teacher.id),  :attachment => {:asset => test_file }
    assert_equal attachment_count+1, teacher.attachments.count
    assert assigns(:teacher)
    assert assigns(:attachment)
    assert_response :success 
    
    #delete existing attachment
    attachment = teacher.attachments.first
    assert_difference("teacher.attachments.count", -1) do
      delete_via_redirect teacher_attachment_path, teacher_id: teacher.id, id: attachment.id
    end
    assert_response :success
    
    #create new locker
    
    teacher = teachers(:three)
    assert_difference("Locker.count") do
      post_via_redirect teacher_locker_path(teacher_id: teacher.id), locker: {locker_number: "L22", compartment: "C"}  
    end
    
    assert assigns(:teacher)
    assert assigns(:locker)
    assert_response :success

     #update locker
    locker_count = Locker.count
    locker = teacher.locker
    assert_no_difference("Locker.count") do
      put_via_redirect teacher_locker_path(teacher, locker), locker: {locker_number: "L22", compartment: "D"}
    end
    assert_equal locker_count, Locker.count
    assert assigns(:teacher)
    assert assigns(:locker)
    assert_response :success
    
    #delete locker
    locker = teacher.locker
    assert_difference("Locker.count", -1) do
      delete_via_redirect teacher_locker_path(teacher), id: locker.id
    end
    assert assigns(:teacher)
    assert_response :success
    assert_equal "Successfully deleted the locker", flash[:notice] 


    

    get logout_path
    assert_response :redirect
    follow_redirect!
    assert_equal "You have been successfully logged out.", flash[:notice] 
  
  end
  
end


