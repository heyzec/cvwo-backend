class Tag < ApplicationRecord
  belongs_to :user

  validates :text, presence: true, length: 1..50
  validates :color, presence: true, format: /\A#[A-Fa-f\d]{6}\Z/
end
