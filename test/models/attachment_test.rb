require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  
  test "should not save invalid data" do
    attachment = Attachment.new
    assert attachment.invalid?
    assert_not attachment.errors[:attachable_id].empty?
    assert_not attachment.errors[:attachable_type].empty?
    assert_not attachment.errors[:asset].empty?
    assert_not attachment.save
  end
end
