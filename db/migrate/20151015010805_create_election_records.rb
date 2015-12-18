class CreateElectionRecords < ActiveRecord::Migration
  def change
    create_table :election_records do |t|
      t.integer :user_id

      #民代類別: 總統、立委、
      t.string :category, null: false

      #onwork_title: 院長、副院長、...民代互選後產生
      t.string :onwork_title

      #選區
      t.string :electorate
      t.string :party

      #選舉投票日
      t.date :vote_date

      #參選結果
      t.integer :result

      #任職期間，可依此取出現任的民代資料。如有提前離職者，更改period_end即可
      t.date :period_start
      t.date :period_end

      t.timestamps null: false
    end
  end
end
