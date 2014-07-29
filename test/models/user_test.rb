require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
 
  test "should not save invalid user " do
    user = User.new
    assert user.invalid?
    assert_not user.errors[:name].empty?
    assert_not user.errors[:email].empty?
    assert_not user.errors[:password].empty?
    assert_not user.save
  end
  
  test "should save the valid user" do
    user = User.new(name: "admin", email: "admin1@gmail.com", password: "admin", password_confirmation: 'admin')    
    assert user.valid?
    assert user.errors[:name].empty?
    assert user.errors[:email].empty?
    assert user.errors[:password].empty?
    assert user.save
  end
  
  test "should check for unique email" do
    existing_user = users(:one)
    user = User.new(name: "admin", email: existing_user.email, password: "admin")
    assert_not user.valid?
    assert_not user.save
    assert_not user.errors[:email].empty?
    assert_equal 1, user.errors[:email].size
    assert_equal "has already been taken", user.errors[:email].first
  end
  
  test "should check for correct email format" do
    user = User.new(name: "admin2", email: "admin2.com", password: "admin2")
    assert_not user.valid?
    assert_not user.save
    assert_not user.errors[:email].empty?
    assert_equal 1, user.errors[:email].size
    assert_equal "please provide a valid email", user.errors[:email].first
  end
  
  test "class method hashed password should return hashed password" do
    temp_password = "12345"
    hashed_password = User.hashed_password(temp_password)
    assert_equal 64, hashed_password.length
  end
  
  test "instance method callback hash_password! should return hash password" do
    user = User.new(name: 'test', email: 'test12344@gmail.com', password: '1234', password_confirmation: '1234')
    plain_password = user.password
    assert user.valid?
    # the before_save callback hash_password! must be called here within the save method
    # and should have changed the actual password to a hashed key
    assert user.save 
    assert_not_equal plain_password, user.password
  end

  test "method authenticate check for user authentication" do
    user = users(:one)
    # we know the default password set in fixtures is password1234
    auth_user = User.authenticate(email: user.email, password: 'password1234')    
    assert_equal User, auth_user.class
  end
  
end


