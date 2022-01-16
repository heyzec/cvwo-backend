class Tag < ApplicationRecord
  # Active Record Associations
  belongs_to :user

  validates :text, presence: true
  validates :color, presence: true, format: /\A#[A-Fa-f\d]{6}\Z/
end
