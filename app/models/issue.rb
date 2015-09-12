class Issue < ActiveRecord::Base
<<<<<<< HEAD
<<<<<<< HEAD

  has_many :votes
  has_many :vote_users, through: :votes, source: :user, :dependent => :destroy
=======
  has_many :votes
  has_many :users, :through => :votes
>>>>>>> b4f7665bba236b9f6044cf55c6c6f9be098a060d

=======
  has_many :votes, :dependent => :destroy
  has_many :users, :through => :votes
>>>>>>> 8f6b277cf09c40e2e933cf21159514f1a526df38
end
