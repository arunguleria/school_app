require 'test_helper'

class LockerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save invalid locker" do
    locker = Locker.new
    assert locker.invalid?
    assert_not locker.errors[:locker_number].empty?
    assert_not locker.errors[:compartment].empty?
    assert_not locker.errors[:teacher_id].empty?
    assert_not locker.save
  end
  
  test "should save the locker" do
    locker = Locker.new(locker_number: "1", compartment: "A", teacher_id: "3")
    assert locker.valid?
    assert locker.errors[:lab_number].empty?
    assert locker.errors[:compartment].empty?
    assert locker.errors[:teacher_id].empty?
    assert locker.save 
  end
  
  test "should check for unique locker number" do
  
    existing_locker = lockers(:one)   
    locker = Locker.new(locker_number: existing_locker.locker_number, compartment: "C", 
    teacher_id: 3)
    assert_not locker.valid?
    assert_not locker.save
    locker.valid?
    p locker.errors.inspect
    assert_not locker.errors[:compartment].empty?
    assert_equal 1, locker.errors[:compartment].size
    assert_equal "same locker number exists for this compartment", locker.errors[:compartment].first
    assert_equal locker.errors[:teacher_id].empty?
    
  end
  
  test "should check for unique teacher id" do
  
    existing_locker = lockers(:one)   
    locker = Locker.new(locker_number: existing_locker.locker_number, compartment: "C", 
    teacher_id:  existing_locker.teacher_id)
    assert_not locker.valid?
    assert_not locker.save
    assert_not locker.errors[:teacher_id].empty?
    assert_equal 1, locker.errors[:teacher_id].size
    assert_equal "has already been taken", locker.errors[:teacher_id].first
  end
  
  # testing association with teacher
  
  test "should featch the associated teacher" do
    locker = lockers(:one)
    assert_equal Teacher, locker.teacher.class
  end
  
  test "should delete locker but not affect the teacher" do
    locker = lockers(:one)
    teacher = locker.teacher
    assert locker.destroy
    assert Teacher.where(:id => teacher.id).first
  end
end
