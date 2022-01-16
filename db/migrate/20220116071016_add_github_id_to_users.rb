class AddGithubIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :github_id, :int
  end
end
