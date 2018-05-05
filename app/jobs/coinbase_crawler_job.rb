class CoinbaseCrawlerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    BitcoinPriceCrawler.coinbase
  end
end
