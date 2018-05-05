class SpeedsmsApi
  API_KEY ='H3By5BhFKk2gjTMnFYUBKLOUn9ajnuo8'
  class << self
    def send(user_id,to,content)
      user = User.find(user_id)

      if user.credits >=10
        uri =URI('http://api.speedsms.vn/index.php/sms/send')
        params = {"to": [to], "content": content, "sms_type": 2, "sender": ""}
        headers={
          "Content-Type" => "application/json"
        }
        response = HTTParty.post(uri,
          body: params.to_json,
          basic_auth: { username: "#{API_KEY}", password: "x" },
          headers: headers)
        if response.code ==200
          user.reload.decrement!(:credits, 10)
          status = response.parsed_response["status"]
          object = SmsLog.new(:provider => 'speedsms',
            :status => status,
            :to_number => to,
            :content => content,
            :user_id => user_id )
          object.save
        end
      end
    end
  end
end
