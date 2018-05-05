class CrawlerBittrexMarket
  include Sidekiq::Worker

  def perform
    BittrexApi.execute
  end
end

