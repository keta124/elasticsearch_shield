class UsdToVnd
  PROXIES = %w[
    http://line1.lichchieu.vn:3800
    http://line2.lichchieu.vn:3800
    http://line3.lichchieu.vn:3800
  ]
  class << self
    def execute
      uri = "https://www.vietcombank.com.vn/ExchangeRates/"
      options = {
        "proxy" => PROXIES.sample
      }
      doc =Nokogiri::HTML open(uri,options).read
      f = doc.css('table#Content_ExrateView.tbl-01.rateTable tr')
      f.each do |e|
        if e.at("td.code") && (e.at("td.code").text =='USD')
          usd_vnd = (e.css('td').last.text.gsub(/\D/,'').to_i/100).to_i
          object = ExchangeUsdVnd.new(:value => usd_vnd)
          object.save
        end
      end
    end
  end
end
