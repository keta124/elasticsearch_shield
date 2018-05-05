class CrawlerCoinbaseMarket
  include Sidekiq::Worker

  def perform
    CoinbaseApi.execute
  end
end

