class UsersController < ApplicationController

  before_action :set_user, :only => [:show, :edit, :update]

  def show
    # @agent = User.where(role: "1").includes(:votes)
    # @user_issues = @user.vote_issues

    # if @user.role == 1
    #   total_user_ids = Vote.where( :issue_id => @user_issues.map(&:id) ).pluck(:user_id).uniq
    #   @total_users = User.find( total_user_ids )

    #   #@total_users = User.includes(:votes).where( "votes.issue_id" => @user_issues.map(&:id) )
    #   #一個query完成
    # end
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
    params.require(:user).permit(:name, :email, :description, :country)
  end


end
