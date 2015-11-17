class VotesController < ApplicationController

  before_action :authenticate_user!

  # Pages
  def agent_list
    @total_agents = User.where(role: "1")
    @agents = @total_agents.page(params[:page]).per(10)
    @all_agent_issues = LatestIssueVote.pluck(:user_id, :issue_id)
    @my_issues = LatestIssueVote.where(:user_id => current_user.id).pluck(:user_id, :issue_id)
  end

  def create
    set_issue
    vote = @issue.find_vote_by_user(current_user)

    unless vote
      @vote = Vote.create(user: current_user, issue: @issue)
    end

    respond_to do |format|
      format.html {redirect_to :back}
      format.js {
        @issue.reload
        render :template => "votes/ajax"
      }
    end
  end

  def destroy
    set_issue
    @vote = current_user.votes.find(params[:id])
    @vote.destroy
    @vote = nil
    respond_to do |format|
      format.html {redirect_to :back}
      format.js {
        @issue.reload
        render :template => "votes/ajax"
      }
    end
  end

  #Ajax

  def like_user
    @agent = User.find(params[:id])
    @latest_agent_vote = LatestAgentVote.find_by(:agent_id=>@agent.id, :user_id=>current_user.id)

    if @latest_agent_vote
      @latest_agent_vote.value = 1
      @latest_agent_vote.save
    else
      LatestAgentVote.create(:agent_id=>@agent.id, :user_id=>current_user.id, :value => 1)
    end
    redirect_to agent_list_path
  end

  def dislike_user
    @agent = User.find(params[:id])
    @latest_agent_vote = LatestAgentVote.find_by(:agent_id=>@agent.id, :user_id=>current_user.id)

    if @latest_agent_vote
      @latest_agent_vote.value = -1
      @latest_agent_vote.save
    else
      LatestAgentVote.create(:agent_id=>@agent.id, :user_id=>current_user.id, :value => -1)
    end
    redirect_to agent_list_path
  end

  def unlike_user
    @agent = User.find(params[:id])
    @latest_agent_vote = LatestAgentVote.find_by(:agent_id=>@agent.id, :user_id=>current_user.id)

    if @latest_agent_vote
      @latest_agent_vote.destroy
    end

    redirect_to agent_list_path
  end

private

  def set_issue
    @issue = Issue.find(params[:issue_id])
  end

end
