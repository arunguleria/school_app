class SubjectsTeachersMap < ActiveRecord::Base

  belongs_to :teacher
  belongs_to :subject

  validates :teacher, presence: true
  validates :subject, presence: true
  
  validates :teacher_id, uniqueness: {scope: [:subject_id]}
  
end
