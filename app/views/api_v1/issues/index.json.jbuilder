response.headers['Access-Control-Allow-Origin'] = '*'
json.data @issues do |issue|
  json.id issue.id
  json.title issue.title
  json.description issue.description
  json.vote_count issue.votes_count
end
