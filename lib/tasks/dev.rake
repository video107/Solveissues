namespace :dev do

  task :fake => :environment do
    User.delete_all
    Issue.delete_all
    Vote.delete_all
    country = %w[台北市 基隆市 新北市 連江縣 宜蘭縣 新竹市 新竹縣 桃園縣 苗栗縣 台中市 彰化縣 南投縣 嘉義市
                 嘉義縣 雲林縣 台南市 高雄市 澎湖縣 金門縣 屏東縣 台東縣 花蓮縣]
    usrenames = %w[零加隆 王晶平 馬一九 無思哇 花媽 沒勝文 扁扁 賴德德 波多野結衣 志玲姐姐 陳小刀 賭神 賭聖 習老大 喔爸爸 東拉蕊 吳中憲]
    100.times do |i|
        puts "fake issues #{i}"
        user = User.create(:email =>Faker::Internet.email, :password => "12345678",role: 0, country: country.sample, :fb_image => Faker::Avatar.image, :name => Faker::Name.name)
        issue = Issue.create!( title:  Faker::App.name,
                      :description => Faker::Lorem.paragraph,
                      :creator => user.id  )
        Vote.create!(user: user, issue: issue)
    end

    10.times do |i|
      puts "fake celebrates #{i}"
      user = User.create(:email =>Faker::Internet.email, :password => "12345678",role: 1, country: country.sample, :fb_image => Faker::Avatar.image, :name => usrenames.sample)
    end

    200.times do |i|
      puts "fake vots #{i}"
      users = User.all
      issues = Issue.all
      Vote.create!(user: users.sample, issue: issues.sample)
    end

  end

  task :fake2 => :environment do
    30.times do |i|
      puts "update normal user #{i}"
      u = User.all.sample
      u.update(role: 0)
    end
  end


  task :fake3 => :environment do
    country = %w[台北市 基隆市 新北市 連江縣 宜蘭縣 新竹市 新竹縣 桃園縣 苗栗縣 台中市 彰化縣 南投縣 嘉義市
                 嘉義縣 雲林縣 台南市 高雄市 澎湖縣 金門縣 屏東縣 台東縣 花蓮縣]
    100.times do |i|
      puts "create normal user #{i}"
      user = User.create(:email =>Faker::Internet.email, :password => "12345678",role: 0, country: country.sample, :fb_image => Faker::Avatar.image, :name => Faker::Name.name)
      issue = Issue.create!( title:  Faker::App.name,
                    :description => Faker::Lorem.paragraph,
                    :creator => user.id  )
    end
  end




end
