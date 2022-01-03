class AddUserToTasksAndTags < ActiveRecord::Migration[6.1]
  # Will need to delete all entries in this model before migration
  def change
    add_reference :tasks, :user, null: false, foreign_key: true
    add_reference :tags, :user, null: false, foreign_key: true
  end
end
