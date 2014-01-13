class Subject < ActiveRecord::Base

  has_many :subjects_teachers_maps, dependent: :destroy
  has_many :teachers, through: :subjects_teachers_maps

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  
end
