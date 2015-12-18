class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.string :name
      t.date :vote_date
      t.string :description
    end
    change_table :election_records do |t|
      t.remove :result
      t.remove :vote_date
      t.string :election_result
      t.integer :election_id
    end
    add_index :election_records, :election_id
  end
end
