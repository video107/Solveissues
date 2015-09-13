class ApiV1::AuthController < ApiController

  before_action :authenticate_user!, :only => :logout

  def login
    success = false

    if params[:email] && params[:password]
      user = User.find_by_email(params[:email])
      success = user && user.valid_password?(params[:password])
      user.generate_authentication_token
      user.save!
    end

    if success
      render :json => { :status => 200,
                        :message => "Login OK",
                        :user => user,
                        :auth_token => user.authentication_token  }
    else
      render :json => { :message => "Login Failed" }, :status => 401
    end
  end

  def logout
    current_user.generate_authentication_token
    current_user.save!

    render :json => { :message => "Logout OK" }
  end

  def options
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Reuqested-With, Content-Type, Accept'
    render :text => "ok"
  end

end
