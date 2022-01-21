class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    # user.authenticate comes from has_secure_password
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash[:alert] = "Invalid email or password"
      render :new, status: 401
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Succesfully logged out"
  end
end