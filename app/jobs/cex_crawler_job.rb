class CexCrawlerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    BitcoinPriceCrawler.cex
  end
end
