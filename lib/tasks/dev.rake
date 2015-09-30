namespace :dev do

  country = %w[台北市 基隆市 新北市 連江縣 宜蘭縣 新竹市 新竹縣 桃園縣 苗栗縣 台中市 彰化縣 南投縣 嘉義市 嘉義縣 雲林縣 台南市 高雄市 澎湖縣 金門縣 屏東縣 台東縣 花蓮縣]
  usrenames = %w[零加隆 王晶平 馬一九 無思哇 花媽 沒勝文 扁扁 賴德德 波多野結衣 志玲姐姐 陳小刀 賭神 賭聖 習老大 喔爸爸 東拉蕊 吳中憲]

  task :demo_data => :environment do
    User.delete_all
    Issue.delete_all
    Vote.delete_all
    puts '清除user, issue, vote'
    puts 'add 100 選民'
    puts 'add 30  民代'
    puts 'add 100 議題'
    puts 'add 1000 議題vote'

    100.times do |i|
        puts "fake 選民+議題 #{i}"
        user = User.create(:email =>Faker::Internet.email, :password => "12345678",role: 0, country: country.sample, :fb_image => Faker::Avatar.image, :name => Faker::Name.name)
        issue = Issue.create!( title:  Faker::App.name,
                      :description => Faker::Lorem.paragraph,
                      :creator => user.id  )
        Vote.create!(user: user, issue: issue)
    end

    30.times do |i|
      puts "fake 民代 #{i}"
      user = User.create(:email =>Faker::Internet.email, :password => "12345678",role: 1, country: country.sample, :fb_image => Faker::Avatar.image, :name => usrenames.sample)
    end

    1000.times do |i|

      user = User.all.sample
      issue = Issue.all.sample
      vote = Vote.new(:issue => issue, :user => user)
      if issue.find_vote_by_user(user)
      else
        vote.save!
        puts "fake 議題vote #{vote.id}"
      end
    end

  end

  task :login_account => :environment do
    puts 'agent@gmail / someone@gmail / pw:12345678'

    user = User.create(:email =>'agent@gmail.com', :password => "12345678",role: 1, country: country.sample, :fb_image => Faker::Avatar.image, :name => usrenames.sample)
    user = User.create(:email =>'someone@gmail.com', :password => "12345678",role: 0, country: country.sample, :fb_image => Faker::Avatar.image, :name => usrenames.sample)

  end

  task :fake3 => :environment do
    100.times do |i|
      puts "create normal user #{i}"
      user = User.create(:email =>Faker::Internet.email, :password => "12345678",role: 0, country: country.sample, :fb_image => Faker::Avatar.image, :name => Faker::Name.name)
      issue = Issue.create!( title:  Faker::App.name,
                    :description => Faker::Lorem.paragraph,
                    :creator => user.id  )
    end
  end


  task :fake4 => :environment do
    500.times do |i|
      puts "create 議題vote #{i}"
      user = User.all.sample
      issue = Issue.all.sample
      vote = Vote.new(:issue => issue, :user => user)
      if issue.find_vote_by_user(user)
      else
        vote.save!
      end
    end
  end

end
