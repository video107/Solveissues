module UsersHelper

  def return_total_user_country_hash(total_user)
    country_hash = Hash.new

    total_user.uniq.each do |user|
      User.find_by_email(user).country
      unless country_hash[User.find_by_email(user).country]
        country_hash[User.find_by_email(user).country]=1
      else
        country_hash[User.find_by_email(user).country]+=1
      end
    end
    country_hash
  end
end
