class CreateTagsAndUpdateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :text
      t.string :color

      t.timestamps
      
    add_column :tasks, :tags, :int, array:true, default: []
    end
  end
end
