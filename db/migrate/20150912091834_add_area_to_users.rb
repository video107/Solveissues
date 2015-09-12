class AddAreaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer
    add_column :users, :area, :string
    add_attachment :users, :photo
  end
end
