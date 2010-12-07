class UsersController < ApplicationController
  before_filter :login_required, :except => [:show]
  protect_from_forgery :except => :update_location

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find_by_username(params[:id])
    @user.soft_validate
    unless @user && @user.available_for_edit_by(current_user)
      flash[:error] = "Not allowed to edit #{params[:id]}"
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by_username(params[:id])
    if current_user == @user
      @user.apply_form_attributes(params[:user])
      begin
        @user.save!
        flash[:notice] = "Profile updated"
      rescue ActiveRecord::RecordInvalid => e
        flash[:error] = "#{e}"
      end
      redirect_to :action => :show, :id => @user.username
    else
      flash[:error] = "Permission denied"
      redirect_to root_path;
    end    
  end

  def update_location
    @user = User.find_by_username(params[:id])
    if current_user == @user
      location = Location.new
      location.apply_form_attributes(params)
      @user.locations << location
    end
    render :nothing => true
  end

  def clock_in
    @user = User.find_by_username(params[:id])
    if current_user == @user
      @user.clock_in!
      flash[:notice] = "#{@user.username} is clocked in for one hour."
    else
      flash[:error] = "Not authorized to clock in #{@user.username}"
    end
    redirect_to root_path
  end

  def clock_out
    @user = User.find_by_username(params[:id])
    if current_user == @user
      @user.clock_out!
      flash[:notice] = "#{@user.username} has been clocked out."
    else
      flash[:error] = "Not authorized to clock out #{@user.username}"
    end
    redirect_to root_path
  end
end
