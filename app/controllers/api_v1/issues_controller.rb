class ApiV1::IssuesController < ApiController

  def index
    @issues = Issue.all
  end

  def show
    @issue = Issue.find(params[:id])
    @celebrates = @issue.vote_users.where(role: 1)
  end

  def create
    @issue = Issue.new( title: params[:title],
                        description: params[:discription],
                        creator: params[:authentication_token]
      )

    if @issue.save
      render :json => { :status => 200,
                        :message => "Issue create ok",
                        :user => user,
                        :auth_token => user.authentication_token,
                        :issue => @issue
                      }

    else
      render :json => { :message => "Issue create fault" }, :status => 401
    end
  end

end
