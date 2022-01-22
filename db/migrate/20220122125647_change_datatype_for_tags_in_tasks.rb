class ChangeDatatypeForTagsInTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :tags, :string, array: true, default: []
  end
end
