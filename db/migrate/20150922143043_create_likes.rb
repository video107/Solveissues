class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :agent_id
      t.boolean :like
      t.timestamps null: false
    end
    add_index :likes, :agent_id
    add_index :likes, :user_id
  end
end
