class ApiV1::UsersController < ApiController

  def same
    @user = User.find_by_authentication_token(params[:authentication_token])
    @issues = @user.vote_issues
    @celebrates = []
    @issues.each do |iss|
      iss.vote_users.where(role: 1).each do |u|
        @celebrates << u.id
      end
    end
  end

  def show
    @user = User.find_by_authentication_token(params[:authentication_token])
    @celebrate = User.find(params[:id])
  end


end
