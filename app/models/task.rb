class Task < ApplicationRecord
  # Active Record Associations: Gives convenience methods to Task objects
  # task.user returns the associated User object, no need to manually find via task.user_id
  belongs_to :list

end
