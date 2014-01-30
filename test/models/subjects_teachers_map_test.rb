require 'test_helper'

class SubjectsTeachersMapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should not save invalid data" do
    map = SubjectsTeachersMap.new
    assert map.invalid?
    assert_not map.errors[:teacher].empty?
    assert_not map.errors[:subject].empty?
    assert_not map.save
  end
  
  test "should save the valid data" do
    map = SubjectsTeachersMap.new(subject_id: 3, teacher_id: 3)
    assert map.valid?
    assert map.errors[:teacher].empty?
    assert map.errors[:subject].empty?
    assert map.save
  end
  
  test "should check for unique teacher_id " do
    existing_teacher = subjects_teachers_maps(:one)
    teacher = SubjectsTeachersMap.new(subject_id: existing_teacher.subject_id, teacher_id: existing_teacher.teacher_id)
    assert_not teacher.valid?
    assert_not teacher.save
    assert_not teacher.errors[:teacher_id].empty?
    assert_equal 1, teacher.errors[:teacher_id].size
    assert_equal "has already been taken", teacher.errors[:teacher_id].first
  end
end
