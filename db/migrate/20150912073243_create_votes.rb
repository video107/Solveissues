class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :issue_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :votes, :issue_id
    add_index :votes, :user_id
  end
end
