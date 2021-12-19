class UpdateForFirstDeployment < ActiveRecord::Migration[6.1]
  def change
    rename_table :tdlists, :tasks
    rename_column :tasks, :title, :text
    add_column :tasks, :day, :string
  end
end
