class SettingsController < BaseController

  def show
  end

  def update_email
    if current_user.update(email: params[:email], phone: params[:phone])
      redirect_to settings_path, notice: 'Your email has been updated!'
    else
      redirect_to settings_path, notice: 'Invalid email!'
    end
  end

  def update_password
    if current_user.valid_password?(params[:current_password])
      current_user.update! password: params[:new_password], password_confirmation: params[:new_password_confirmation]
    else
      redirect_to settings_path, notice: 'Wrong current password!'
    end
  end

end
