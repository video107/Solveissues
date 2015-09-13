json.id @issue.id
json.title @issue.title
json.description @issue.description
json.vote_count @issue.votes_count
json.reps @celebrates do |cel|
  json.id cel.id
  json.name cel.name
  json.picture cel.fb_image
  vote_issues = []
  cel.vote_issues.each do |iss|
    vote_issues << iss.id
  end
  json.vote_issues vote_issues.uniq
  same_issues = []
  user_issues = []
  user = User.find_by_authentication_token(params[:authentication_token])
  user.vote_issues.each do |iss|
    user_issues << iss.id
  end
  same_issues = vote_issues + user_issues
  return_same_issues = same_issues.select {|x| same_issues.count(x) >1 }.uniq
  json.same_issues return_same_issues.uniq
end
