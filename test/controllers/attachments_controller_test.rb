require 'test_helper'

class AttachmentsControllerTest < ActionController::TestCase
  setup do
    @attachment = attachments(:one)
  end

=begin  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attachments)
  end
=end  
  test "should fetch attachment" do
    login_as(:one)
    teacher = teachers(:one)
    get :index, teacher_id: teacher.id
    assert_response :success
  end
  
  
=begin  test "should get new" do
    get :new
    assert_response :success
  end
=end
  test "should create attachment" do
    login_as(:one)
    teacher = teachers(:one)
    attachment_count = Attachment.count
    assert_difference("teacher.attachments.count") do
      post :create, teacher_id: teacher.id, :attachment => {:asset => fixture_file_upload('/files/logo.jpg', 'image/jpg') }
    end
    assert assigns(:teacher)
    assert assigns(:attachment)
    assert_response :redirect
    assert_redirected_to teacher_attachment_path(teacher_id: assigns(:teacher), id: assigns(:attachment))
    assert_equal "Attachment was successfully created.", flash[:notice]
    assert_equal attachment_count+1, Attachment.count
    
  end

=begin  test "should show attachment" do
    get :show, id: @attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attachment
    assert_response :success
  end

  test "should update attachment" do
    patch :update, id: @attachment, attachment: {  }
    assert_redirected_to attachment_path(assigns(:attachment))
  end
=end
  test "should destroy attachment" do
    login_as(:one)
    teacher = teachers(:one)
    attachment = teacher.attachments.first
    assert_difference('Attachment.count', -1) do
      delete :destroy, teacher_id: teacher.id, id: attachment.id
    end
    assert_response :redirect
    assert_redirected_to teacher_attachments_path
  end
end
