require 'test_helper'

class LockersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  
  test "should fetch locker" do
    login_as(:one)
    teacher = teachers(:one)
    locker = teacher.locker
    get :index
    assert_response :success
  end
  
end
