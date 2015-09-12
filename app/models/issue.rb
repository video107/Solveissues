class Issue < ActiveRecord::Base

  has_many :votes
  has_many :vote_users, through: :votes, source: :user, :dependent => :destroy

end
