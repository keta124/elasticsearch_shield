class ConditionsController < BaseController

  def index
    redirect_to "/users/sign_in" if !current_user
    @conditions = current_user&.conditions
    @conditions_active = @conditions.where(active: true)
    @conditions_inactive = @conditions.where(active: false)
    @sms = SmsLog.where(user_id: current_user).limit(30).order( 'created_at DESC' )
  end

  def new
    @condition = current_user.conditions.new
  end

  def create
    if current_user.credits >= 10
      @condition = current_user.conditions.new condition_params
      if @condition.save
        redirect_to conditions_path
      else
        render :new
      end
    else
      redirect_to "/charging"
    end
  end

  def edit
    @condition = current_user.conditions.find params[:id]
  end

  def update
    @condition = current_user.conditions.find params[:id]
    if @condition.update condition_params
      redirect_to conditions_path
    else
      render :edit
    end
  end

  def destroy
    condition = current_user.conditions.find params[:id]
    condition.destroy!
    redirect_to conditions_path
  end

  private

  def condition_params
    params.require(:condition).permit :source, :coin, :currency, :operation, :value
  end

end
