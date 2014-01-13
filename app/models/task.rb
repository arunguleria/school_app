class Task < ActiveRecord::Base
  
  PRIORITIES = ["High", "Medium", "Low"]
  
  belongs_to :teacher
   
  validates :title, presence: true
  validates :description, presence: true
  validates :priority, inclusion: {in: Task::PRIORITIES, message: "please provide a valid priority"}
  validates :teacher, presence: true

  scope :high, -> {where(priority: "High")}
  scope :medium, -> {where(priority: "Medium")}
  scope :low, -> {where(priority: "Low")}
  scope :completed, -> {where(is_completed: true)}
  scope :incompleted, -> {where(is_completed: false)}
  
  
  # marks a task as completed
  def complete!
    self.update_attribute(:is_completed, true)
    # TODO: send an email to teacher about taks completion
  end
  
  # marks a task as incompleted
  def incomplete!
    self.update_attribute(:is_completed, false)
    # TODO: send an email to teacher about tasks reopening
  end
  
end
