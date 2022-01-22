class User < ApplicationRecord
  has_many :links, dependent: :delete_all
  has_many :lists, through: :links
  has_many :tags, dependent: :delete_all

  validates :email, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :password, length: {minimum: 6, allow_nil: true}

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
 
  # Remove password_digest column when converting model record into json
  def as_json(options = {})
    super(options.merge({ except: [:password_digest] }))
  end
end
