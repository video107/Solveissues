class Issue < ActiveRecord::Base
  has_many :votes, :dependent => :destroy
  has_many :users, :through => :votes
end
