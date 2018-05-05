class CryptopiaApi
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

      response = open('https://www.cryptopia.co.nz/api/GetMarkets',
        :proxy => PROXIES.sample,
        :read_timeout=>60).read
      res = JSON.parse(response)
      price = res["Data"].map{|e| [e["Label"],e["LastPrice"]]}.to_h

      if ExchangeCoin.where("market='gdax' AND coin='BTC'").last.nil?
        btc_to_usd = 0
      else
        btc_to_usd = ExchangeCoin.where("market='gdax' AND coin='BTC'").last.price_usd
      end

      coin_btc = price.select { |k, v| k.to_s.end_with?('/BTC') }
      coin_usdt = price.select { |k, v| k.to_s.end_with?('/USDT') }

      coin_price_btc = coin_btc.map {|k, v| [k.gsub('/BTC', ''), v]}.to_h
      coin_price_btc['BTC'] =1
      coin_price_usdt = coin_usdt.map {|k, v| [k.gsub('/USDT', ''), v]}.to_h

      coin_price_btc.keys.each do |key|
        btc = coin_price_btc[key]
        usdt = coin_price_usdt[key]
        usd =  coin_price_btc[key] * btc_to_usd
        vnd = usd * usd_to_vnd
        object = ExchangeCoin.new(:market =>'cryptopia',
            :coin=>key,
            :price_btc => btc,
            :price_usd => usd.round(6),
            :price_usdt => usdt,
            :price_vnd => vnd.round
            )
        object.save
      end
    end

    def get_coins
      ExchangeCoin.where(["created_at > ? and market='cryptopia'", 1.days.ago]).select(:coin).distinct.map {|e| e[:coin]}
    end
  end
end
