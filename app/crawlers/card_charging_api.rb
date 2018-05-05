class CardChargingApi
  MERCHANT_ID = 48353
  API_USER ='5a3a87009548c'
  API_PASSWORD ='96e3c18f270c9b0ef0bdb0e7c090e86f'
  class << self
    def get_info card_type
      url ='https://sv.gamebank.vn/trang-thai-he-thong-2'
      response = open(url).read
      res = JSON.parse(response)
      case card_type
      when 1
        res.last["Viettel"]
      when 2
        res.last["Mobiphone"]
      when 3
        res.last["Vinaphone"]
      end
    end

    def check_valid(pin,seri,card_type) #123456789234567
      if card_type == 1 and (pin.length == 13 or pin.length == 15) and (seri.length == 11 or seri.length ==14)
        return true
      elsif card_type == 2 and (pin.length == 12 or pin.length == 15) and (seri.length == 14 or seri.length == 15)
        return true
      elsif card_type == 3 and (pin.length == 12 or pin.length == 14) and seri.length == 14
        return true
      else
        return false
      end
    end

    def execute(user_id,pin,seri,card_type)
      card_type_ =card_type.to_i
      if (get_info(card_type_).to_i == 1) and check_valid(pin,seri,card_type_)
        url = "http://sv.gamebank.vn/api/card2?merchant_id=#{MERCHANT_ID}&api_user=#{API_USER}&api_password=#{API_PASSWORD}&pin=#{pin}&seri=#{seri}&card_type=#{card_type_}&note="
        response = open(url,:read_timeout=>120).read
        res = JSON.parse(response)
        code = res["code"]
        msg = res["msg"]
        info_card = res["info_card"]
        transaction_id = res["transaction_id"]
        case code
        when 0
          status = 0 # thanh cong
          credit_card = info_card.to_i / 100
          user = User.find(user_id)
          user.update! credits: (user.credits + credit_card)
        when 4, 19, 22
          status = 1 # the da su dung roi
        when 6, 8, 12, 24
          status =2 # lien he admin
        when 7, 30
          status =3 # He thong dang bao tri
        else
          status = -1 # co loi xay ra
        end
        object = TelcoCardChargingLog.new(:provider => 'gamebank',
          :code => code,
          :msg => msg,
          :info_card => info_card,
          :transaction_id => transaction_id,
          :user_id => user_id )
        object.save
        status
      else
        status = -1
      end
    end
  end
end

