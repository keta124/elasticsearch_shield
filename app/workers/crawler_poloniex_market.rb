class CrawlerPoloniexMarket
  include Sidekiq::Worker

  def perform
    PoloniexApi.execute
  end
end
