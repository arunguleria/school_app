require 'test_helper'

class LabdeskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should not save invalid labdesk" do
    labdesk = Labdesk.new
    assert labdesk.invalid?
    assert_not labdesk.errors[:lab_number].empty?
    assert_not labdesk.errors[:lab_type].empty?
    assert_not labdesk.errors[:student].empty?
    assert_not labdesk.save
  end
  
  test "should save the labdesk" do
    labdesk = Labdesk.new(lab_number: "1", lab_type: "physics", student_id: "1")
    assert labdesk.valid?
    assert labdesk.errors[:lab_number].empty?
    assert labdesk.errors[:lab_type].empty?
    assert labdesk.errors[:student_id].empty?
    assert labdesk.save 
  end
  
  test "should check for unique labnumber and student" do
    existing_labdesk = labdesks(:one)
    labdesk = Labdesk.new(lab_number: existing_labdesk.lab_number, lab_type: existing_labdesk.lab_type, student_id: existing_labdesk.student_id)
    assert_not labdesk.valid?
    assert_not labdesk.save
    
    assert_not labdesk.errors[:lab_type].empty?
    assert_equal 1, labdesk.errors[:lab_type].size
    assert_equal "same lab number exists for this lab", labdesk.errors[:lab_type].first
    
    assert labdesk.errors[:student].empty?
  end
  
  test "should fetch the associated student" do
    labdesk = labdesks(:one)
    assert_equal Student, labdesk.student.class
  end
  
  test "should delete labdesk but should not affect the student" do
    labdesk = labdesks(:one)
    student = labdesk.student
    assert labdesk.destroy
    assert Student.where(:id => student.id).first
  end
  
end


