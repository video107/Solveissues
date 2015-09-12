class Vote < ActiveRecord::Base
<<<<<<< HEAD

  belongs_to :user, :dependent => :destroy;
  belongs_to :issue, :counter_cache => true, :dependent => :destroy;
=======
  belongs_to :user
  belongs_to :issue
>>>>>>> 8f6b277cf09c40e2e933cf21159514f1a526df38
end
