require 'csv'
arrs = CSV.read("config/Representation.csv")
arrs[1..arrs.length].each do |row|

  user = User.find_or_initialize_by(name: row[0].to_s)
  user.email = Faker::Internet.email
  user.password = SecureRandom.hex
  user.birthday = Date.parse(row[1]) if row[1]
  user.gender = row[2]
  user.role = 1
  user.fb_image = Faker::Avatar.image

  election_record = user.election_records.new
  election_record.party = row[3]
  election_record.electorate = row[4]
  election_record.category = row[5]
  election_record.onwork_title = row[6]
  election_record.election_result = row[7].to_i
  election_record.period_start = Date.parse(row[9]) if row[9]
  election_record.period_end = Date.parse(row[10]) if row[10]
  election_record.note = row[11]
  election_record.election = Election.find_by(vote_date: Date.parse(row[8])) if row[8]
  user.save

end
