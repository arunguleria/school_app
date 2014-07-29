class Labdesk < ActiveRecord::Base

  TYPES = ["physics","chemistry","biology"]
  
  belongs_to :student
  
  validates :lab_number, presence: true
  validates :lab_type, inclusion: {in: Labdesk::TYPES, message: "please provide a valid lab"},
    uniqueness: {scope: [:lab_number, :student_id], message: "same lab number exists for this lab"}
  validates :student, presence: true
  
  
  scope :physics, -> {where(lab_type: "physics")}
  scope :chemistry, -> {where(lab_type: "chemistry")}
  scope :biology, -> {where(lab_type: "biology")} 
  
  
end
