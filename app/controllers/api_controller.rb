class ApiController < ActionController::Base

  before_action :authenticate_user_from_token!
  after_action :add_after_action

  protected

  def authenticate_user_from_token!

   if params[:auth_token].present?
    user = User.find_by_authentication_token(params[:auth_token])

    if user
     sign_in user, store: false
    end
   end

  end

  def add_after_action
    response.headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
  end

end
