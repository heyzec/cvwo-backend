class Task < ApplicationRecord
  belongs_to :list
  validates :text, presence: true
  
  validate :validate_tags_length

  def validate_tags_length
    errors.add(:tags, 'Found tags with too many chars') unless self.tags.all? { |tag| tag.length <= 32 }
  end
  
end
