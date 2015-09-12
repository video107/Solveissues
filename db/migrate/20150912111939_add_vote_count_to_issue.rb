class AddVoteCountToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :votes_count, :integer
  end
end
