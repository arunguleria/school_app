class Player < ActiveRecord::Base

  validates :name, presence: true
  validates :club, presence: true
  validates :country, presence: true
  
end
