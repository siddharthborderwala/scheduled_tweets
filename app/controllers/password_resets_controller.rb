class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_later
    end
    
    redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password"
  end

  def edit
    begin
      @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to signin_path, alert: "Your token has expired, please try again."
    end
  end

  def update
    begin
      @user = User.find_signed!(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to signin_path, alert: "Your token has expired, please try again."
    end
    if @user.update(password_params)
        redirect_to signin_path, notice: "Your password was reset successfully, please sign in."
    else
      render :edit
    end
  end

  private
  
  def password_params
    params.require(:user).permit(:password, :password_confirm)
  end
end