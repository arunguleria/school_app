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
  
  
  # associations testing
  test "should fetch tasks associated with the teacher" do
    teacher = teachers(:one)
    tasks = teacher.tasks
    assert_not tasks.empty? # we have two tasks in fixtures for the teacher one.    
  end
  
  test "should create a new task" do
    teacher = teachers(:one)
    tasks_count = teacher.tasks.count
    task = teacher.tasks.build(title: "Annual Function", description: "ready the schedule for annual function", priority: Task::PRIORITIES.first)
    assert task.save
    assert_equal tasks_count+1, teacher.tasks.count
  end
  
  test "should delete an existing task related to the teacher" do
    teacher = teachers(:one)
    tasks_count = teacher.tasks.count
    task = teacher.tasks.first
    assert task.destroy
    assert_equal tasks_count-1, teacher.tasks.count
  end
    
  test "should delete all associated tasks when the teacher gets deleted" do
    teacher = teachers(:one)
    assert_not Task.where(teacher_id: teacher.id).empty?
    assert teacher.destroy
    assert Task.where(teacher_id: teacher.id).empty?
  end
  
  test "should fetch subjects associated with the teacher" do
    teacher = teachers(:one)
    subjects = teacher.subjects
    assert_not subjects.empty? # we have two tasks in fixtures for the teacher one.    
  end
  
  test "should create a new subject" do
    teacher = teachers(:one)
    subjects_count = teacher.subjects.count
    subject = Subject.new(name: "C", description: "loops,statements")
    assert subject.save
    subject_map = teacher.subjects_teachers_maps.build(subject_id: subject.id)
    assert subject_map.save
    assert_equal subjects_count+1, teacher.subjects.count
  end
  
  test "should delete an existing subject related to the teacher" do
    teacher = teachers(:one)
    subjects_count = teacher.subjects.count
    subject = teacher.subjects.first
    assert subject.destroy
    assert_equal subjects_count-1, teacher.subjects.count
  end
  
  test "should delete all associated subjects when the teacher gets deleted" do
    teacher = teachers(:one)
    assert_not SubjectsTeachersMap.where(teacher_id: teacher.id).empty?
    assert teacher.destroy
    assert SubjectsTeachersMap.where(teacher_id: teacher.id).empty?
  end
  
  test "should fetch locker associated with the teacher" do
    teacher = teachers(:one)
    locker = teacher.locker
    assert_not locker.nil? #one locker in fixtures for the teacher one
  end
  
  test "should create a new locker" do
    teacher = teachers(:one)
    locker_count = Locker.count
    locker = Locker.new(locker_number: "L22", compartment: "C", teacher_id: 3)
    assert locker.save
    assert_equal locker_count+1, Locker.count
  end
  
  test "should delete an existing locker related to the teacher" do
    teacher = teachers(:one)
    locker_count = Locker.count
    locker = teacher.locker
    assert locker.destroy
    assert_equal locker_count-1, Locker.count
  end
  
  test "should delete locker when the teacher gets deleted" do
    teacher = teachers(:one)
    assert_not Locker.where(teacher_id: teacher.id).empty?
    assert teacher.destroy
    assert Locker.where(teacher_id: teacher.id).empty?
  end
  
  test "should fetch photos associated with the teacher" do
    teacher = teachers(:one)
    photos = teacher.photos
    assert_not photos.empty?
  end
  
  test "should create a new photo" do
    teacher = teachers(:one)
    photo_count = teacher.photos.count
    teacher.photos << Photo.new(filename: "my_photo.jpeg", file_type: "JPEG")
    assert_equal photo_count+1, teacher.photos.count
  end
  
  test "should delete an existing photo related to the teacher" do
    teacher = teachers(:one)
    photos_count = teacher.photos.count
    photo = teacher.photos.first
    assert photo.destroy
    assert_equal photos_count-1, teacher.photos.count
  end
  
  test "should delete photos when the teacher gets deleted" do
    teacher = teachers(:one)
    assert_not Photo.where(photographable_id: teacher.id, photographable_type: 'Teacher').empty?
    assert teacher.destroy
    assert Photo.where(photographable_id: teacher.id, photographable_type: 'Teacher').empty?
  end
  
  test "should fetch attachment associated with the teacher" do
    teacher = teachers(:one)
    attachments = teacher.attachments
    assert_not attachments.empty?
  end
  
  test "should create a new attachment" do
    teacher = teachers(:one)
    attachment_count = teacher.attachments.count
    teacher.attachments << Attachment.new(asset_file_name: "my_photo.jpeg", asset_content_type: "image/jpeg", asset_file_size: 1000)
    assert_equal attachment_count+1, teacher.attachments.count
  end
  
  test "should delete an existing attachment related to the teacher" do
    teacher = teachers(:one)
    attachment_count = teacher.attachments.count
    attachment = teacher.attachments.first
    assert attachment.destroy
    assert_equal attachment_count-1, teacher.attachments.count
  end
  
  test "should delete attachments when the teacher gets deleted" do
    teacher = teachers(:one)
    assert_not Attachment.where(attachable_id: teacher).empty?
    assert teacher.destroy
    assert Attachment.where(attachable_id: teacher).empty?
  end
end












