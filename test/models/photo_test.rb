require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should not save invalid data" do
    photo = Photo.new
    assert photo.invalid?
    assert_not photo.errors[:filename].empty?
    assert_not photo.errors[:file_type].empty?
    assert_not photo.save
  end
  
  test "should save the valid data" do
    photo = Photo.new(filename: "my_photo.jpeg", file_type: "JPEG")
    assert photo.valid?
    assert photo.errors[:filename].empty?
    assert photo.errors[:file_type].empty?
    assert photo.save
  end
  
  # testing association with teacher
  
  test "should fetch the associated teacher" do
    photo = photos(:one)
    assert_equal Teacher, photo.photographable.class
  end
  
  test "should delete photo but should not affect the interface object" do
    photo = photos(:one)
    photographable = photo.photographable
    assert photo.destroy
    assert photographable.reload
  end
end



