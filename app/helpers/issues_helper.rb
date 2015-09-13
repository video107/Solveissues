module IssuesHelper
  def has_vote?(user,issue)
    if user.votes.where(:issue_id => issue.id)
      '我支持'
    end
  end

end
