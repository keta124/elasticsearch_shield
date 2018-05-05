class ChargingController < BaseController
  def index
    redirect_to "/users/sign_in" if !current_user
  end
  def show
  end
  def create
    permit_param = charging_params
    user_id = current_user.id
    code =CardChargingApi.execute(user_id, permit_param["pin"],permit_param["serial"], permit_param["card_type"])
    puts code
    case code
    when -1
      @status = "Có lỗi xảy ra, vui lòng thử lại"
    when 0
      @status = "Nạp thẻ thành công"
    when 1
      @status = "Thẻ đã sử dụng rồi"
    when 2
      @status = "Có lỗi xảy ra, liên hệ admin để xử lý"
    when 3
      @status = "Hệ thống đang bảo trì, thử lại sau"
    else
      @status = "Có lỗi xảy ra, vui lòng thử lại"
    end
    #render :json => { :status => @status }
    # render :inline => 
    #   "<p><%= @status %><p>"
    redirect_to :controller => 'charging',notice: @status
  end
  def charging_params
    params.permit :pin, :serial, :card_type
  end
end
