class Issue < ActiveRecord::Base
<<<<<<< HEAD

  has_many :votes
  has_many :vote_users, through: :votes, source: :user, :dependent => :destroy
=======
  has_many :votes
  has_many :users, :through => :votes
>>>>>>> b4f7665bba236b9f6044cf55c6c6f9be098a060d

end
