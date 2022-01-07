class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.string :text
      t.timestamps
    end
    
    remove_reference(:tasks, :user)
    add_reference :tasks, :list, null: false, foreign_key: true
    
    # using "has_and_belongs_to_many" instead of "has_many :through" to create
    # a many to many association

    create_table :lists_users, id: false do |t|  # For some reason users_lists doesn't work
      t.belongs_to :list, :foreign_key => "id"
      t.belongs_to :user, :foreign_key => "id"
    end
  end
end
