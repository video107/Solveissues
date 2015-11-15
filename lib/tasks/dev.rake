namespace :dev do

  country = %w[台北市 基隆市 新北市 連江縣 宜蘭縣 新竹市 新竹縣 桃園縣 苗栗縣 台中市 彰化縣 南投縣 嘉義市 嘉義縣 雲林縣 台南市 高雄市 澎湖縣 金門縣 屏東縣 台東縣 花蓮縣]
  usrenames = %w[零加隆 王晶平 馬一九 無思哇 花媽 沒勝文 扁扁 賴德德 波多野結衣 志玲姐姐 陳小刀 賭神 賭聖 習老大 喔爸爸 東拉蕊 吳中憲]

  task :test_db_rebuild => ['db:drop:all', 'db:create', 'db:migrate', 'db:seed', 'dev:mass_user', 'dev:user_vote', 'dev:agent_votes']

  #task :agent_history => :environment do
  #  puts "產生一個月名聲紀錄"
  #  AgentHistory.delete_all
  #  agents = User.where(:role => 1)
  #  agents.each do |x|
  #    30.times do |i|
  #      history_data = AgentHistory.create(:user_id => x.id, :date => i.days.ago, :likes => Faker::Number.number(3))
  #    end
  #  end
  #end

  # OK
  task :mass_user => :environment do
    CONN = ActiveRecord::Base.connection
    inserts = []
    time = Time.now.to_s(:db)
    a = User.all.count
    (a..a + 100).each do |n|
      # 避免email重覆
      email = "a#{n}@email.com"
      inserts.push %Q{('#{email}', '12345678', 0, '#{country.sample}', '#{Faker::Avatar.image}', '#{Faker::Internet.user_name}', '#{time}', '#{time}')}
    end
    sql = "INSERT INTO users (email, encrypted_password, role, country, fb_image, name, created_at, updated_at) VALUES #{inserts.join(", ")}"
    begin
      CONN.execute sql
      puts '新增 1萬筆 User'
    rescue
      puts '失敗'
    end
  end

  task :user_vote => :environment do
    Vote.delete_all
    User.all.each {|u|
      inserts =[]
      hash = {}
      u.role == 1 ? times = [5,10,15,20,25,35].sample : times = [3,5,7,9,11].sample
      if u.role == 1
        times = [5,10,15,20,25,35].sample
        vote_scope = "agent"
      else
        times = [3,5,7,9,11].sample
        vote_scope = nil
      end

      Issue.all.sample(times).each{|i|
        # hash = {:user => u, :issue => i}
        hash = {:voter_type => "User", :voter_id => u.id, :votable_type => "Issue", :votable_id => i.id, :vote_scope => vote_scope,
          :vote_weight => 1, :vote_flag => true
        }
        inserts.push hash
      }
      vote = Vote.create(inserts)
    }
    puts "每人投10票"
  end


  task :create_seed_elections => :environment do
    Election.create(:name => "2014-九合一選舉", :vote_date => "2014/11/29")
    Election.create(:name => "2016-第14任總統大選", :vote_date => "2016/01/16")
    Election.create(:name => "2012-第13任總統大選", :vote_date => "2012/01/14")
    Election.create(:name => "2010-直轄市市長暨市議員選舉(五都選舉)", :vote_date => "2010/11/27")
    Election.create(:name => "2015-第8屆立委缺額補選", :description => "南投縣第2選區、屏東縣第3選區、臺中市第6選區、彰化縣第4選區、苗栗縣第2選區" , :vote_date => "2014/2/7")
    Election.create(:name => "2013-第8屆立委臺中市第2選區缺額補選", :vote_date => "2013/1/26")
  end


  task :agent_votes => :environment do
    puts "每人給立委，20次"
    LatestAgentVote.destroy_all
    HistoricalAgentVote.destroy_all

    agent = []
    User.where(:role=>1).each do |a|
      agent.push(a.id)
    end

    @agents = User.where(:role => 1)
    d = 31

    30.times do

      time_date = d.day.ago.strftime("%Y-%m-%d")
      d -= 1
      puts "每個人在#{time_date}向五個立委投票"

      User.all.each do |u|
        agent.sample(5).each do |i|
          lastest = LatestAgentVote.find_by(:agent_id=>i, :user_id=>u.id)
          if lastest.present?
            lastest.update(:value => [1,-1].sample)
          else
            LatestAgentVote.create(:agent_id=>i, :user_id=>u.id, :value => [1,-1].sample)
          end
        end
      end

      puts "建立歷史投票記錄 每天"
      @agents.each do |agent|
        yes_user = []
        no_user = []

        LatestAgentVote.where(:agent_id=>agent.id, :value=>1).each do |lav|
            yes_user.push(lav.user_id)
        end

        LatestAgentVote.where(:agent_id=>agent.id, :value=>-1).each do |lav|
            no_user.push(lav.user_id)
        end

        exist = HistoricalAgentVote.find_by(:agent_id=>agent.id, :vote_date=>time_date)

        if exist.present?
          exist.update(:agent_id=>agent.id, :likes_count=>yes_user.count, :dislikes_count=>no_user.count, :liked_users=>yes_user, :disliked_users=>no_user, :vote_date=>time_date)
        else
          HistoricalAgentVote.create(:agent_id=>agent.id, :likes_count=>yes_user.count, :dislikes_count=>no_user.count, :liked_users=>yes_user, :disliked_users=>no_user, :vote_date=>time_date)
        end
      end

    end
  end


  task :historical_agent_votes => :environment do
    puts "建立每日立委投票人數（每日排程）"
    time_date = Time.now.strftime("%Y-%m-%d")

    @agents = User.where(:role => 1)

    @agents.each do |agent|
      yes_user = []
      no_user = []
      LatestAgentVote.where(:agent_id=>agent.id, :value=>1).each do |lav|
        yes_user.push(lav.user_id)
      end
      LatestAgentVote.where(:agent_id=>agent.id, :value=>-1).each do |lav|
        no_user.push(lav.user_id)
      end

      exist = HistoricalAgentVote.find_by(:agent_id=>agent.id, :vote_date=>time_date)

      if exist.present?
        exist.update(:agent_id=>agent.id, :likes_count=>yes_user.count, :dislikes_count=>no_user.count, :liked_users=>yes_user, :disliked_users=>no_user, :vote_date=>time_date)
      else
        HistoricalAgentVote.create(:agent_id=>agent.id, :likes_count=>yes_user.count, :dislikes_count=>no_user.count, :liked_users=>yes_user, :disliked_users=>no_user, :vote_date=>time_date)
      end
    end
  end

# =========以下為舊的===================
  task :demo_data => :environment do
    # 產生 Demo用的基本data

    ActiveRecord::Base.transaction do
      puts '產生10000個選民'
      10.times do |i|
          user = User.create(:email =>Faker::Internet.email, :password => "12345678",role: 0, country: country.sample, :fb_image => Faker::Avatar.image, :name => Faker::Name.name)
          Vote.create!(user: user, issue: Issue.all.sample)
      end
      puts '產生40000筆投票'
      30.times do |i|
        user = User.all.sample
        issue = Issue.all.sample
        vote = Vote.new(:issue => issue, :user => user)
        vote.save! unless issue.find_vote_by_user(user)
      end
    end

  end


end
