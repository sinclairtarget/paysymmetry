class SessionsController < ApplicationController
  INVALID_LOGIN_ALERT =
    'The login information you provided was incorrect.'

  skip_before_action :authorize

  def new
    redirect_to groups_path if session[:user_id].present?
  end

  def create
    email = params[:email]
    password = params[:password]

    if @user = User.find_by_email(email) and @user.authenticate(password)
      session[:user_id] = @user.id
      redirect_to groups_path
    else
      redirect_to login_path, alert: INVALID_LOGIN_ALERT
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
