class PasswordsController < ApplicationController
  before_action :require_user_logged_in!

  def edit
  end

  def update
    if Current.user.authenticate(params[:user][:current_password])
      if Current.user.update(password_params)
        redirect_to root_path, notice: "Password updated!"
      end
    else
      redirect_to edit_password_path, alert: "Incorrect password"
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end