class MiningInfoController < ApplicationController

  def show_mining_status
    respond_to do |format|
      format.html
      format.json do
        h = { data: [] }
        coins = ["ETN","XMR","AEON"]
        coins.each do |coin|
          difficulty = Rails.cache.read("#{coin}_difficulty")
          block_reward = Rails.cache.read("#{coin}_block_reward")
          if difficulty.nil? or block_reward.nil?
            select_condition = CoinCalculator.where(["coin = ? AND created_at >?",coin,1.days.ago])
            diffs = select_condition.pluck("difficulty")
            rewards = select_condition.pluck("block_reward")
            Rails.cache.write "#{coin}_difficulty", (diffs.reduce(:+) /  diffs.size)
            Rails.cache.write "#{coin}_block_reward", (rewards.reduce(:+) /  rewards.size)
          end
          h[:data] << [
            coin,
            Rails.cache.read("#{coin}_difficulty"),
            Rails.cache.read("#{coin}_block_reward"),
          ]
        end
        render json: h
      end
    end
  end

  def calculator_rewards
    permit_param = calculator_params
    coin = permit_param["coin"]
    hashrate = permit_param["hashrate"].to_f
    block_reward = Rails.cache.read("#{coin}_block_reward") || 0
    difficulty = Rails.cache.read("#{coin}_difficulty") || 1
    case coin
    when "ETN"
      result = ((hashrate * block_reward ) / difficulty  * 1440 )
      price_btc = result * ( Rails.cache.read "cryptopia_#{coin}_btc_last" || 0 )
      price_usd = result * ( Rails.cache.read "cryptopia_#{coin}_usd_last" || 0 )
      price_vnd = result * ( Rails.cache.read "cryptopia_#{coin}_vnd_last" || 0 )
    when  "XMR" , "AEON"
      result = ((hashrate * block_reward ) / difficulty  * 1440 )
      price_btc = result * ( Rails.cache.read "bittrex_#{coin}_btc_last" || 0 )
      price_usd = result * ( Rails.cache.read "bittrex_#{coin}_usd_last" || 0 )
      price_vnd = result * ( Rails.cache.read "bittrex_#{coin}_vnd_last" || 0 )
    when "BTC"
      result = (hashrate * block_reward ) / difficulty  * 1440 / 2**32
      price_btc = result * ( Rails.cache.read "bittrex_#{coin}_btc_last" || 0 )
      price_usd = result * ( Rails.cache.read "bittrex_#{coin}_usd_last" || 0 )
      price_vnd = result * ( Rails.cache.read "bittrex_#{coin}_vnd_last" || 0 )
    else
      result =0
    end

    h = { data: [] }
    h[:data] << [
      result.round(6),
      price_btc.round(8),
      price_usd.round(6),
      price_vnd.round(0).to_i,
    ]
    render json: h

  end

  def calculator_params
    params.permit :coin, :hashrate, :type_algorithm
  end

end
