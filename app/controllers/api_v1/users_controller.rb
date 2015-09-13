class ApiV1::UsersController < ApiController

  def same
    @user = User.find_by_authentication_token(params[:authentication_token])
    @issues = @user.vote_issues
    @celebrates = nil
    @issues.each do |iss|
      @celebrates << iss.vote_users.where(role: 1)
    end
  end

end
