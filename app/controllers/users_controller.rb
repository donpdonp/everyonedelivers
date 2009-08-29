class UsersController < ApplicationController
  before_filter :login_required, :only => [:edit, :update]
  protect_from_forgery :except => :update_location

  def show
    @user = User.find_by_username(params[:id])
    @listed_deliveries = Delivery.all(:conditions => {:listing_user_id => @user.id}, :order => "created_at desc, delivering_user_id asc")
    @listed_deliveries = @listed_deliveries.select{|d| d.ok_to_display? }
    @accepted_deliveries = Delivery.all(:conditions => {:delivering_user_id => @user.id}, :order => "created_at desc, delivering_user_id asc")
    @accepted_deliveries = @accepted_deliveries.select{|d| d.ok_to_display? }
  end

  def edit
    @user = User.find_by_username(params[:id])
  end

  def update
    @user = User.find_by_username(params[:id])
    if current_user == @user
      flash[:notice] = "Profile updated"
      @user.apply_form_attributes(params[:user])
      @user.save!
      redirect_to :action => :show, :id => @user.username
    else
      flash[:notice] = "Permission denied"
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
    else
      flash[:error] = "Not authorized to clock in {@user.username}"
    end
  end

  def clock_out
    @user = User.find_by_username(params[:id])
    if current_user == @user
      @user.clock_out!
    else
      flash[:error] = "Not authorized to clock out {@user.username}"
    end
  end
end
