class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(:openid_identifier => params[:openid_identifier])
    if @user_session.save
      flash[:notice] = "Login successful!"
    else
      flash[:notice] = "Login failed."
    end
      redirect_back_or_default root_path
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end
end
