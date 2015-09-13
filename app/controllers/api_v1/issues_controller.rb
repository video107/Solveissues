class ApiV1::IssuesController < ApiController

  def index
    @issues = Issue.all
  end

  def show
    @issue = Issue.find(params[:id])
    @celebrates = @issue.vote_users.where(role: 1)
  end


end
