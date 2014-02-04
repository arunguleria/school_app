require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save invalid task" do
    task = Task.new
    assert task.invalid?
    assert_not task.errors[:title].empty?
    assert_not task.errors[:description].empty?
    assert_not task.errors[:priority].empty?
    assert_not task.errors[:teacher].empty?
    assert_not task.save
  end
  
  test "should save the valid task" do 
    task = Task.new(title: "social work", description: "social", priority: "High", teacher_id: 1)
    assert task.valid?
    assert task.errors[:title].empty?
    assert task.errors[:description].empty?
    assert task.errors[:priority].empty?
    assert task.errors[:teacher].empty?
    assert task.save
  end
  
  test "high scope should return high priority tasks" do
    assert_equal  Task.high.count, Task.where(priority: 'High').count
    existing_high_count = Task.high.count
    task = Task.create(title: "social work", description: "social", priority: "High", teacher_id: 1)
    assert_equal Task.high.count, existing_high_count + 1
  end
  
  test "medium scope should return medium priority tasks" do
    assert_equal Task.medium.count, Task.where(priority: 'Medium').count
    existing_medium_count = Task.medium.count
    task = Task.create(title: "work", description: "social", priority: "Medium", teacher_id: 2)
    assert_equal Task.medium.count, existing_medium_count + 1
  end
  
  test "low scope should return low priority tasks" do
    assert_equal Task.low.count, Task.where(priority: 'Low').count
    existing_low_count = Task.low.count
    task = Task.create(title: "work", description: "social", priority: "Low", teacher_id: 3)
    assert_equal Task.low.count, existing_low_count + 1
  end
  
  test "should return completed tasks" do
    assert_equal Task.completed.count, Task.where(is_completed: true).count
    existing_completed_count = Task.completed.count
    
  end 
  test "should return incompleted tasks" do
    assert_equal Task.incompleted.count, Task.where(is_completed: false).count
    existing_incompleted_count = Task.incompleted.count
    
  end
  
  test "method complete! should mark the task as completed" do
    task = tasks(:one)
    assert_not task.is_completed
    completed_count = Task.completed.count
    incompleted_count = Task.incompleted.count
    task.complete!
    assert task.is_completed
    assert_equal Task.completed.count, completed_count + 1
    assert_equal Task.incompleted.count, incompleted_count - 1
  end
  
  test "method incomplete! should mark the task as incompleted" do
    task = tasks(:one)
    assert_not task.is_completed
    completed_count = Task.completed.count
    incompleted_count = Task.incompleted.count
    task.incomplete!
    assert_not task.is_completed
    assert_equal Task.incompleted.count, incompleted_count
  end
  
  # testing association with teacher
  
  test "should featch the associated teacher" do
    task = tasks(:one)
    assert_equal Teacher, task.teacher.class
  end
  
  test "should delete task but should not affect the teacher" do
    task = tasks(:one)
    teacher = task.teacher
    assert task.destroy
    assert Teacher.where(:id => teacher.id).first
  end
  
  
end



