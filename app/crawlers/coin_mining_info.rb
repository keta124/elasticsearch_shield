class CoinMiningInfo
  PROXIES = %w[
    http://line1.lichchieu.vn:3800
    http://line2.lichchieu.vn:3800
    http://line3.lichchieu.vn:3800
  ]
  class << self
    def etn_execute
      uri = "https://blockexplorer.electroneum.com/"
      options = {
        "proxy" => PROXIES.sample
      }
      doc =Nokogiri::HTML open(uri,options).read
      difficulty = doc.css(".center h3").last.children.text.split("\n").select{|e| e.include? "Network difficulty"}.to_s.gsub(/\D/,'').to_f
      block_reward = doc.css("table.center").last.css("tr")[1].css("td")[5].children.text.to_f
      object = CoinCalculator.new(:coin => "ETN", 
        :difficulty => difficulty,
        :block_reward => block_reward,
        :type_algorithm => 1)
      object.save

      select_condition = CoinCalculator.where(["coin = ? AND created_at >?",'ETN',1.days.ago])
      diffs = select_condition.pluck("difficulty")
      rewards = select_condition.pluck("block_reward")
      Rails.cache.write "ETN_difficulty", (diffs.reduce(:+) /  diffs.size).round(2)
      Rails.cache.write "ETN_block_reward", (rewards.reduce(:+) /  rewards.size).round(2)
    end

    def xmr_execute
      uri = "https://moneroblocks.info/api/get_stats"
      options = {
        "proxy" => PROXIES.sample
      }
      doc =Nokogiri::HTML open(uri,options).read
      res = JSON.parse(doc.text)
      object = CoinCalculator.new(:coin => "XMR", 
        :difficulty => res["difficulty"],
        :block_reward => ( res["last_reward"].to_f / 10**12 ) ,
        :type_algorithm => 1)
      object.save
      
      select_condition = CoinCalculator.where(["coin = ? AND created_at >?",'XMR',1.days.ago])
      diffs = select_condition.pluck("difficulty")
      rewards = select_condition.pluck("block_reward")
      Rails.cache.write "XMR_difficulty", (diffs.reduce(:+) /  diffs.size).round(2)
      Rails.cache.write "XMR_block_reward", (rewards.reduce(:+) /  rewards.size).round(2)

    end

    def aeon_execute
      uri = "https://chainradar.com/api/v1/aeon/status"
      options = {
        "proxy" => PROXIES.sample
      }
      doc =Nokogiri::HTML open(uri,options).read
      res = JSON.parse(doc.text)
      object = CoinCalculator.new(:coin => "AEON", 
        :difficulty => res["difficulty"],
        :block_reward => ( res["reward"].to_f / 10**12 ) ,
        :type_algorithm => 1)
      object.save
      
      select_condition = CoinCalculator.where(["coin = ? AND created_at >?",'AEON',1.days.ago])
      diffs = select_condition.pluck("difficulty")
      rewards = select_condition.pluck("block_reward")
      Rails.cache.write "AEON_difficulty", (diffs.reduce(:+) /  diffs.size).round(2)
      Rails.cache.write "AEON_block_reward", (rewards.reduce(:+) /  rewards.size).round(2)
    end

  end
end
