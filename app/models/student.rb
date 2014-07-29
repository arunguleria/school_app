class Student < ActiveRecord::Base
  
  has_many :photos, as: :photographable
  
  # has_one :labdesk, dependent: :nullify
  has_many :labdesks, dependent: :destroy
  
  validates :first_name,
      presence: true, length: {within: 3..20}
  validates :last_name, 
      presence: true, length: {within: 3..20}
  validates :email,
     format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: 'provide a valid email'},
     uniqueness: true
  
  def name
    "#{first_name} #{last_name}"
  end

end
