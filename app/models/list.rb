class List < ApplicationRecord
  has_many :links
  has_many :users, through: :links
  has_many :tasks, dependent: :delete_all
  validates :text, presence: true
end
