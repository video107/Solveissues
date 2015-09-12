class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        :confirmable

  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(fb_uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.fb_uid = auth.uid
     user.password = Devise.friendly_token[0,20]
     user.fb_image = auth.info.image # assuming the user model has an image
    end
    # if auth.credentials
    #   user.fb_access_token = auth.credentials.token
    #   user.fb_expires_at = Time.at(auth.credentials.expires_at)
    # end
    # user.save
    # user
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end



  def generate_authentication_token
    token = nil

    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end

    self.authentication_token = token
  end

  def user_name
    if self
       self.email.split("@").first
    else
      "Guest"
    end
  end
end
