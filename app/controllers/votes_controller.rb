class VotesController < ApplicationController

  before_action :authenticate_user!

  def create
    if current_user.votes.find_by_issue_id(params[:issue_id])
      @vote = current_user.votes.create(:issue_id => params[:issue_id])
      @issue_id = params[:issue_id]
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def destroy
    @vote = current_user.votes.find_by_issue_id(params[:issue_id])
    if @vote
      @vote.destroy
      @issue_id = params[:issue_id]
      respond_to do |format|
        format.html
        format.js{ }
      end
    end
  end


end
