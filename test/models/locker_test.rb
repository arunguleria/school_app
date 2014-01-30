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
    locker = Locker.new(locker_number: "1", compartment: "A", teacher_id: "1")
    assert locker.valid?
    assert locker.errors[:lab_number].empty?
    assert locker.errors[:compartment].empty?
    assert locker.errors[:teacher_id].empty?
    assert locker.save 
  end
  
  test "should check for unique locker number" do
  
    existing_locker = lockers(:one)   
    locker = Locker.new(locker_number: existing_locker.locker_number, compartment: "A", teacher_id: 1)
    assert_not locker.valid?
    assert_not locker.save
    assert_not locker.errors[:locker_number].empty?
   
    assert_equal 1, locker.errors[:locker_number].size
    assert_equal "has already been taken", locker.errors[:locker_number].first
  end
end
