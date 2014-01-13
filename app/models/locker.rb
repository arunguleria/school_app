class Locker < ActiveRecord::Base

  belongs_to :teacher

  validates :locker_number, presence: true
  validates :compartment, presence: true, uniqueness: {scope: [:locker_number], message: "same locker number exists for this compartment"}  
  validates :teacher_id, presence: true, uniqueness: true

end

