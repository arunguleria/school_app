require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save invalid student" do
    student = Student.new
    assert student.invalid?
    assert_not student.errors[:first_name].empty?
    assert_not student.errors[:last_name].empty?
    assert_not student.errors[:email].empty?
    assert_not student.save
  end
  
  test "should save the valid student" do
    student = Student.new(first_name: "ram", last_name: "lal", email: "ram@lal.com")
    assert student.valid?
    assert student.errors[:first_name].empty?
    assert student.errors[:last_name].empty?
    assert student.errors[:email].empty?
    assert student.save
  end
  
  test "should check for unique email" do
    existing_student = students(:one)
    student = Student.new(first_name: "shyam", last_name: "lal", email: existing_student.email)
    assert_not student.valid?
    assert_not student.save
    assert_not student.errors[:email].empty?
    assert_equal 1, student.errors[:email].size
    assert_equal "has already been taken", student.errors[:email].first
    
  end
  
  test "should check for valid email format" do
    student = Student.new(first_name: "shyam", last_name: "lal", email: "shyamlal.com")
    assert student.invalid?
    assert_not student.save
    assert_not student.errors[:email].empty?
    assert_equal 1, student.errors[:email].size
    assert_equal "provide a valid email", student.errors[:email].first
  end
  
  test "should check for min and mx length for first_name and last_name" do
   student = Student.new(first_name: "as", last_name: "qw")
   assert_not student.valid?
   assert_equal "is too short (minimum is 3 characters)", student.errors[:first_name].first
   assert_equal "is too short (minimum is 3 characters)", student.errors[:last_name].first
   
   student.first_name = "Some very long name which should fail the validation"
   student.last_name = "Some very long name which should fail the validation"
   assert_not student.valid?
   assert_equal "is too long (maximum is 20 characters)", student.errors[:first_name].first
   assert_equal "is too long (maximum is 20 characters)", student.errors[:last_name].first
   assert_not student.save
    
  end
  
  test "name method should return a complete name" do
    student = students(:one)
    assert_equal "#{student.first_name} #{student.last_name}", student.name
  end
  
  #teting associations
  
  test "should fetch labdesks associated with the student" do
    student = students(:one)
    labdesks = student.labdesks
    assert_not labdesks.empty? # we have two labdesks in fixtures for the student one.    
  end
  
  test "should create a new labdesk" do
    student = students(:one)
    labdesks_count = student.labdesks.count
    labdesk = student.labdesks.build(lab_number: "l23", lab_type: Labdesk::TYPES.first)
    assert labdesk.save
    assert_equal labdesks_count+1, student.labdesks.count
  end
  
  test "should delete an existing labdesk related to the student" do
    student = students(:one)
    labdesks_count = student.labdesks.count
    labdesk = student.labdesks.first
    assert labdesk.destroy
    assert_equal labdesks_count-1, student.labdesks.count
  end
    
  test "should delete all associated labdesks when the student gets deleted" do
    student = students(:one)
    assert_not Labdesk.where(student_id: student.id).empty?
    assert student.destroy
    assert Labdesk.where(student_id: student.id).empty?
  end
  
end
