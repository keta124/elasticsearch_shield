class CrawlerCryptopiaMarket
  include Sidekiq::Worker

  def perform
    CryptopiaApi.execute
  end
end

