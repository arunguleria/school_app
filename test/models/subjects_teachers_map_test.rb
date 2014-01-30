require 'test_helper'

class SubjectsTeachersMapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should not save invalid data" do
    map = SubjectsTeachersMap.new
  end
end
