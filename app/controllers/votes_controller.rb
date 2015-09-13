class VotesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_issue

  def create
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


    # if current_user.votes.find_by_issue_id(params[:issue_id])
    #   @vote = current_user.votes.create(:issue_id => params[:issue_id])
    #   @issue_id = params[:issue_id]
    #   respond_to do |format|
    #     format.html
    #     format.js
    #   end
    # end
  end

  def destroy
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
  #   @vote = current_user.votes.find_by_issue_id(params[:issue_id])
  #   if @vote
  #     @vote.destroy
  #     @issue_id = params[:issue_id]
  #     respond_to do |format|
  #       format.html
  #       format.js{ }
  #     end
  #   end
  # end


private

  def set_issue
    @issue = Issue.find(params[:issue_id])
  end


end
