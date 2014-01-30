require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save invalid subject" do
    subject = Subject.new
    assert subject.invalid?
    assert_not subject.errors[:name].empty?
    assert_not subject.errors[:description].empty?
    assert_not subject.save
  end
  
  test "should save valid subject" do
    subject = Subject.new(name: "criket", description: "interesting game")
    assert subject.valid?
    assert subject.errors[:name].empty?
    assert subject.errors[:description].empty?
    assert subject.save
  end
  
  test "should check for unique name" do
    existing_subject = subjects(:one)
    subject = Subject.new(name: existing_subject.name, description: "related to subject")
    assert subject.invalid?
    assert_not subject.valid?
    assert_not subject.save
    assert_not subject.errors[:name].empty?
    assert_equal 1, subject.errors[:name].size
    assert_equal "has already been taken", subject.errors[:name].first
    
    
  end
  
end
