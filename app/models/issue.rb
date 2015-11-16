class Issue < ActiveRecord::Base


  has_many :votes, :dependent => :destroy
  has_many :vote_users, through: :votes, source: :user, :dependent => :destroy

  # Liked by users
  has_many :latest_issue_votes, dependent: :destroy
  has_many :liked_users, through: :latest_issue_votes, source: :user, dependent: :destroy

  acts_as_votable

  def find_vote_by_user(user)
    self.votes.where(user_id: user.id).first
  end

  def like_by_user?(current_user)
    self.liked_users.include?(current_user)
  end




end
