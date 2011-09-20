class SessionController < ApplicationController

  def login_token
    User.find_by_login_token(params[:login_token])
  end

  def logout
    reset_session
    flash[:notice] = "logged out"
    redirect_to :root
  end

end
