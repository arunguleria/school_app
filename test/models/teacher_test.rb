require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  
=begin  
  test "the truth" do
    assert false
  end
=end
  
  test "should not save invalid teacher" do
    teacher = Teacher.new
    assert teacher.invalid?    
    assert_not teacher.errors[:first_name].empty?
    assert_not teacher.errors[:last_name].empty?
    assert_not teacher.errors[:email].empty?
    assert_not teacher.save
  end
  
  test "should set the default salutation" do
    teacher = Teacher.new
    assert_not teacher.valid?
    # salutation will be set to default in callback in the model
    assert teacher.errors[:salutation].empty?
    assert_equal "Mr.", teacher.salutation
  end  
  
  test "should save the valid teacher" do
    teacher = Teacher.new(salutation: "Mr.", first_name: "Rohit", last_name: "Sharma", email: "rohit.sharma@gmail.com")
    assert teacher.valid?    
    assert teacher.errors[:first_name].empty?
    assert teacher.errors[:last_name].empty?
    assert teacher.errors[:email].empty?
    assert teacher.errors[:salutation].empty?
    assert teacher.save    
  end

  test "should check for unique email" do
    existing_teacher = teachers(:one)
    teacher = Teacher.new(first_name: "Sumit", last_name: "Agarwal", email: existing_teacher.email)
    assert_not teacher.valid?
    assert_not teacher.save
    assert_not teacher.errors[:email].empty?
    assert_equal 1, teacher.errors[:email].size
    assert_equal "has already been taken", teacher.errors[:email].first
  end
  
  test "should check for correct email format" do
    teacher = Teacher.new(first_name: "Sumit", last_name: "Agarwal", email: "sumit.agarwal")
    assert_not teacher.valid?
    assert_not teacher.save
    assert_not teacher.errors[:email].empty?
    assert_equal 1, teacher.errors[:email].size
    assert_equal "provide a valid email", teacher.errors[:email].first
  end

  test "name method should return a complete name of the teacher" do
    teacher = teachers(:one)
    assert_equal "#{teacher.salutation} #{teacher.first_name} #{teacher.last_name}", teacher.name
  end

  test "should check for min and max length of first_name and last_name" do
    teacher = Teacher.new(first_name: "AB", last_name: "XY")
    assert_not teacher.valid?
    assert_equal "is too short (minimum is 3 characters)", teacher.errors[:first_name].first
    assert_equal "is too short (minimum is 3 characters)", teacher.errors[:last_name].first
    
    teacher.first_name = "Some very long name which should fail the validation"
    teacher.last_name = "Some very long name which should fail the validation"
    assert_not teacher.valid?
    assert_equal "is too long (maximum is 20 characters)", teacher.errors[:first_name].first
    assert_equal "is too long (maximum is 20 characters)", teacher.errors[:last_name].first
    
    assert_not teacher.save
  end
    
 # test "should check for unique email" do
    # teacher = Teacher.new
  
 # end
    
  
end


