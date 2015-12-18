class Adduserfbinformation < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :description
      t.string :register_homecity
      t.date :birthday
      t.string :gender
    end
  end
end
