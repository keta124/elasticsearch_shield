class HomeController < ApplicationController
  layout false

  def index
    redirect_to conditions_path if current_user
  end

end
