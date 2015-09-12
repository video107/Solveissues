class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_image, :string
    add_column :users, :fb_uid, :string
    add_column :users, :fb_access_token, :string
    add_column :users, :fb_expires_at, :datetime
    add_column :users, :authentication_token, :string

    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string

    add_index :users, :authentication_token, :unique => true
    add_index :users, :fb_uid
  end
end
