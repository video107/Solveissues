namespace :dev do

  task :fake => :environment do
    User.delete_all
    Issue.delete_all
    Vote.delete_all
    country = %w[台北市 基隆市 新北市 連江縣 宜蘭縣 新竹市 新竹縣 桃園縣 苗栗縣 台中市 彰化縣 南投縣 嘉義市
                 嘉義縣 雲林縣 台南市 高雄市 澎湖縣 金門縣 屏東縣 台東縣 花蓮縣]
    10.times do |i|
        puts "fake issues #{i}"
        user = User.create(:email =>Faker::Internet.email, :password => "12345678",role: 1, country: country.sample, :fb_image => Faker::Avatar.image)
        issue = Issue.create!( title:  Faker::App.name,
                      :description => Faker::Lorem.paragraph,
                      :creator => user.id  )
        Vote.create!(user: user, issue: issue)
    end

    30.times do |i|
      puts "fake vots #{i}"
      users = User.all
      issues = Issue.all
      Vote.create!(user: users.sample, issue: issues.sample)
    end

  end





end
