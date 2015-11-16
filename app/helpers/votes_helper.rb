module VotesHelper

  def reputation(agent)
    rep_yes = LatestAgentVote.where(:agent_id=>agent.id, :value=>1).count
    rep_no = LatestAgentVote.where(:agent_id=>agent.id, :value=>-1).count
    total_rep = rep_yes-rep_no
    total_rep
  end

  def vote?(agent, value)
    if current_user.vote_to_agents.include?(agent)
      if current_user.latest_agent_votes.where(:agent=>agent, :value=>value).present?
      "btn-success"
      else
      "btn-default"
      end
    else
      "btn-default"
    end
  end

end
