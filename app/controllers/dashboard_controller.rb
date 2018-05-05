class DashboardController < ApplicationController
  def index
    if !current_user
      redirect_to "/bittrex"
    else
      redirect_to conditions_path
    end
  end 
end
