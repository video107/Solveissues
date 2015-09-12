class Issue < ActiveRecord::Base


  has_many :votes, :dependent => :destroy
  has_many :vote_users, through: :votes, source: :user, :dependent => :destroy

end
