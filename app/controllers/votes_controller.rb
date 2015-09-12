class VotesController < ApplicationController

  before_action :authenticate_user!

  def create
    current_user.vote.create(params[:id])
    redirect_to issues_path
  end

  def destroy
    Vote.find(params[:id]).destroy
    redirect_to issues_path
  end

end
