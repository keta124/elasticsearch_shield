class CrawlerGdaxMarket
  include Sidekiq::Worker

  def perform
    GdaxApi.execute
  end
end

