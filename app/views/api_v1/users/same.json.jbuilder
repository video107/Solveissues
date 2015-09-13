json.data @celebrates.each do |cel|
  rep = User.find(cel)
  json.id rep.id
  json.name rep.name
  json.picture rep.fb_image
  vote_issues = []
  rep.vote_issues.each do |iss|
    vote_issues << iss.id
  end
  json.vote_issues vote_issues.uniq
  same_issues = []
  user_issues = []
  @user.vote_issues.each do |iss|
    user_issues << iss.id
  end
  same_issues = vote_issues + user_issues
  return_same_issues = same_issues.select {|x| same_issues.count(x) >1 }.uniq
  json.same_issues return_same_issues.uniq
end
