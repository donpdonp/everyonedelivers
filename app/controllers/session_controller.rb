class SessionController < ApplicationController

  def login_token
    User.find_by_login_token(params[:login_token])
  end

  def login
    user = User.find_by_email(params[:email])
    if user
      UserMailer.welcome_email(user).deliver
    else
      User.create(:email => params[:email])
    end
  end

  def logout
    reset_session
    flash[:notice] = "logged out"
    redirect_to :root
  end

end
