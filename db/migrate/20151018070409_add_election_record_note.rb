class AddElectionRecordNote < ActiveRecord::Migration
  def change
    add_column :election_records, :note, :string
  end
end
