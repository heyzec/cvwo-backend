class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  
  # Active Record Associations: Gives convenience methods to User objects
  # user.tasks returns the associated Task objects
  has_and_belongs_to_many :lists
  has_many :tags
  
  def password
    @password
  end
  
  
  def password=(raw)
    @password = raw
    self.password_digest = BCrypt::Password.create(raw) 
  end
  
  def is_password?(raw)
    BCrypt::Password.new(password_digest).is_password?(raw)
  end
end
