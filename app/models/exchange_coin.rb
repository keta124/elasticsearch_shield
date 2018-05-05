class ExchangeCoin < ApplicationRecord
  after_create :check_conditions
  after_create :update_cache

  private
  def check_conditions
    Condition.where(source: market, coin: coin, active: true).each do |condition|
      CheckConditionWorker.perform_async(condition.id)
    end
  end

  def update_cache
    Rails.cache.write "#{market}_#{coin}_btc_last", price_btc
    Rails.cache.write "#{market}_#{coin}_usd_last", price_usd
    Rails.cache.write "#{market}_#{coin}_vnd_last", price_vnd

    btc_high = Rails.cache.fetch("#{market}_#{coin}_btc_high") { price_btc }
    if price_btc > btc_high
      Rails.cache.write "#{market}_#{coin}_btc_high", price_btc
    end

    usd_high = Rails.cache.fetch("#{market}_#{coin}_usd_high") { price_usd }
    if price_usd > usd_high
      Rails.cache.write "#{market}_#{coin}_usd_high", price_usd
    end

    vnd_high = Rails.cache.fetch("#{market}_#{coin}_vnd_high") { price_vnd }
    if price_vnd > vnd_high
      Rails.cache.write "#{market}_#{coin}_vnd_high", price_vnd
    end

    btc_low = Rails.cache.fetch("#{market}_#{coin}_btc_low") { price_btc }
    if price_btc < btc_low
      Rails.cache.write "#{market}_#{coin}_btc_low", price_btc
    end

    usd_low = Rails.cache.fetch("#{market}_#{coin}_usd_low") { price_usd }
    if price_usd < usd_low
      Rails.cache.write "#{market}_#{coin}_usd_low", price_usd
    end

    vnd_low = Rails.cache.fetch("#{market}_#{coin}_vnd_low") { price_vnd }
    if price_vnd < vnd_low
      Rails.cache.write "#{market}_#{coin}_vnd_low", price_vnd
    end
  end
end

# == Schema Information
#
# Table name: exchange_coins
#
#  id         :integer          not null, primary key
#  market     :string
#  coin       :string
#  price_btc  :decimal(20, 10)
#  price_usd  :decimal(20, 10)
#  price_vnd  :decimal(20, 10)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  price_usdt :decimal(20, 10)
#
# Indexes
#
#  index_exchange_coins_on_market_and_coin  (market,coin)
#
