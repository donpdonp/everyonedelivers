class UsersController < ApplicationController

  def show
    @user = User.find_by_username(params[:id])
    @listed_deliveries = Delivery.all(:conditions => {:listing_user_id => @user.id})
    @accepted_deliveries = Delivery.all(:conditions => {:delivering_user_id => @user.id})
  end
end
