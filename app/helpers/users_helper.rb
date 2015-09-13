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
    # r_html = ""
    # country_hash.each_key do |k|
    #   r_html << %Q(<span class="label label-warning">#{k}:#{country_hash[k]}</span>)
    # end
    # r_html
  end
end
