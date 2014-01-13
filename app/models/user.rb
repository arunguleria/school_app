class User < ActiveRecord::Base
  
  
  
  validates :name, presence: true
  validates :email,
     format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: ' please provide a valid email'},
     uniqueness: true
  
  validates :password, presence: true, confirmation: true
  
  
  class << self
    
    def authenticate(options={})
      where(email: options[:email], password: hashed_password(options[:password])).first
    end
    
    def hashed_password(password)
      Digest::SHA2.hexdigest(password)  
    end
  end
  
  after_validation :hash_password!
  
  private
  
  def hash_password!
    self.password = User.hashed_password(password)
  end
  
end
