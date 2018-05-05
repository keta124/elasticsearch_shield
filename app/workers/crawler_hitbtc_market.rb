class CrawlerHitbtcMarket
  include Sidekiq::Worker

  def perform
    HitbtcApi.execute
  end
end

