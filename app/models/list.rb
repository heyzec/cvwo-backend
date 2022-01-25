class List < ApplicationRecord
  has_many :links, dependent: :delete_all
  has_many :users, through: :links
  has_many :tasks, dependent: :delete_all
  validates :text, presence: true
  
  
  def generate_share_hash
    hash = SecureRandom.urlsafe_base64(24, false)
    self.update(share_hash: hash)
    hash
  end
  

  # Grab all tags that are indirectly associated with this list
  def tags
    self.tasks.map{ |task| task.tags }.flatten
  end
end
