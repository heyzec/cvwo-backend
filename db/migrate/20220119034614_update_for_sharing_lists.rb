class UpdateForSharingLists < ActiveRecord::Migration[6.1]
  def change
    add_column :lists, :share_hash, :string
    
    # Prevent duplicate relations e.g. One user having multiple of the same tasks
    add_index :lists_users, [:list_id, :user_id], :unique => true

    rename_table :lists_users, :links
  end
end
