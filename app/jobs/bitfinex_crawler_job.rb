class BitfinexCrawlerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    BitcoinPriceCrawler.bitfinex
  end
end
