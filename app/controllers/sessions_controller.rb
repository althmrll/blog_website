class SessionsController < ApplicationController
  skip_before_action :require_user, raise: false

  def new
  end

  def create
    username = params[:username] || params.dig(:user, :username)
    password = params[:password] || params.dig(:user, :password)

    user = User.find_by(username: username)

    if user&.authenticate(password)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully!", status: :see_other
    else
      flash.now[:alert] = "Invalid username or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully!", status: :see_other
  end
end
