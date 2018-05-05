class CrawlerUsdVnd
  include Sidekiq::Worker

  def perform
    UsdToVnd.execute
  end
end

