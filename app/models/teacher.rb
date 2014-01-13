class Teacher < ActiveRecord::Base
  
  
  
  has_many :photos, as: :photographable

  has_many :subjects_teachers_maps, dependent: :destroy
  has_many :subjects, through: :subjects_teachers_maps

  has_one :locker, dependent: :destroy
  has_many :tasks, dependent: :destroy, order: "tasks.created_at desc"


  validates :salutation, presence: true

  validates :first_name,
    presence: true,
    length: {within: 3..20}
    # on: :update
    
  validates :last_name,
    presence: true,
    length: {within: 3..20}
    # on: :update
  
  validates :email, 
    format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: 'provide a valid email'},
    uniqueness: true
    
  
  
  # validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  # validates :terms_and_conditions, acceptance: true

  # validates :password, confirmation: true
  
  def name
    "#{salutation} #{first_name} #{last_name}"
  end


=begin EXAMPLE  
  before_validate :set_salutation
  def set_salutation
  end  
=end

  before_validation do
    print "Before Validate Called \n"    
    self.salutation = "Mr." if self.salutation.to_s.empty? 
  end

  after_validation do
    print "After Validate Called \n" 
  end

  
  before_create do
    print "Before Create Called \n"
  end
  before_save do
    print "Before Save Called \n"
  end

  after_create do
    print "After Create Called \n"
  end
  after_save do
    print "After Save Called \n"
  end

end









