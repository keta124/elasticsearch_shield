class GdaxApi
  PROXIES = %w[
    http://line1.lichchieu.vn:3800
    http://line2.lichchieu.vn:3800
    http://line3.lichchieu.vn:3800
  ]
  class << self
    def execute
      if ExchangeUsdVnd.last.nil?
        usd_to_vnd = 22750
      else 
        usd_to_vnd = (ExchangeUsdVnd.last.value).to_i
      end
      
      coins = %w[
        BTC
        ETH
        LTC
        BCH
      ]
      coin_usd ={}
      coin_price ={}
      coins.each do |coin|
        uri = "https://api.gdax.com/products/#{coin}-USD/book"
        response = open(uri,
          :proxy => PROXIES.sample,
          :read_timeout=>25).read
        res = JSON.parse(response)
        coin_usd[coin]=res["bids"][0][0].to_f
        coin_price[coin]=[
          (coin_usd[coin]/coin_usd['BTC']).round(8),
          coin_usd[coin],
          (coin_usd[coin]*usd_to_vnd).round
        ]
      end
      coin_price.each do |key, value|
        object = ExchangeCoin.new(:market =>'gdax',
            :coin=>key,
            :price_btc =>value[0],
            :price_usd =>value[1],
            :price_vnd =>value[2])
        object.save
      end
    end
    def get_coins
      ExchangeCoin.where(["created_at > ? and market='gdax'", 1.days.ago]).select(:coin).distinct.map {|e| e[:coin]}
    end
  end
end
