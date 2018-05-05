class CrawlerCoinMiningInfo
  include Sidekiq::Worker

  def perform
    CoinMiningInfo.etn_execute
    CoinMiningInfo.xmr_execute
    CoinMiningInfo.aeon_execute
  end
end

