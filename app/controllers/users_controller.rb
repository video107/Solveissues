class UsersController < ApplicationController

  before_action :set_user, :only => [:show, :edit, :update]
  before_action :get_history_likes, :only => :show

  def show
    @user_issues = @user.like_issues
    # @total_users = User.includes(:votes).where("votes.votable_type" => "Issue", "votes.votable_id" => @user_issues.map(&:id))

    # total_user_ids = Vote.where(:votable_id => @user_issues.map(&:id), :votable_type => "Issue").pluck(:voter_id).uniq
    # @total_users = User.find( total_user_ids )
    # @agents = User.where(:role => 1, :id => total_user_ids).includes(:votes)

    # @agent = User.where(role: "1").includes(:votes)
    # @user_issues = @user.vote_issues

    # if @user.role == 1
    #   total_user_ids = Vote.where( :issue_id => @user_issues.map(&:id) ).pluck(:user_id).uniq
    #   @total_users = User.find( total_user_ids )

    #   #@total_users = User.includes(:votes).where( "votes.issue_id" => @user_issues.map(&:id) )
    #   #一個query完成
    # end

    # total_user_ids = Vote.where(:votable_id => @user_issues.map(&:id), :votable_type => "Issue").pluck(:voter_id).uniq
    total_like_user_ids = LatestIssueVote.where(:issue_id => @user_issues.map(&:id)).pluck(:user_id).uniq
    # @all_agent_issues = LatestIssueVote.pluck(:user_id, :issue_id)
    # @my_issues = LatestIssueVote.where(:user_id => current_user.id).pluck(:user_id, :issue_id)
    @agents = User.where(:role => 1, :id => total_like_user_ids)

  end

  def edit
  end

  def update
    if @user.update!(user_params)
      flash[:success] = "更新成功"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end


  def agent_show

  end



private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :description, :country, :register_homecity, :birthday, :gender, :information_attributes => [:party, :job, :party_job, :experience, :election_position, :experience, :election_area])
  end

  def get_history_likes
    @likes_history = HistoricalAgentVote.where(:agent_id => @user)
    @likes = []
    @date = []

    @likes_history.each do |x|
      @likes.push((x.likes_count - x.dislikes_count).to_i)
      @date.push(x.vote_date.to_s)
    end
  end


end
