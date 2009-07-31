class UsersController < ApplicationController
  before_filter :login_required, :only => [:edit, :update]
  protect_from_forgery :except => :update_location

  def show
    @user = User.find_by_username(params[:id])
    @listed_deliveries = Delivery.all(:conditions => {:listing_user_id => @user.id})
    @listed_deliveries = @listed_deliveries.select{|d| d.ok_to_display? }
    @accepted_deliveries = Delivery.all(:conditions => {:delivering_user_id => @user.id})
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
    render :nothing => true
  end
end
