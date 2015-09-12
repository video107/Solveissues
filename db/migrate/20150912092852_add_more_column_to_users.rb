class AddMoreColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :description, :text
    rename_column :users, :area, :country
  end
end
