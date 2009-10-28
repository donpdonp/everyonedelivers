class DeliveriesController < ApplicationController
  before_filter :login_required, :only => [:create, :edit, :update]

  def index
    @delivery_groups = [ ]
    one_month = Delivery.find_at_most_hours_old(24*31).select{|d| d.ok_to_display?}
    @delivery_groups << ["less than a month old", one_month] if one_month.size > 0
    #four_hours = Delivery.find_between_hours_old(1,4).select{|d| d.ok_to_display?}
    #@delivery_groups << ["one to four hours old", four_hours] if four_hours.size > 0
    #many_hours = Delivery.find_more_than_hours_old(4).select{|d| d.ok_to_display?}
    #@delivery_groups << ["more than four hours old", many_hours] if many_hours.size > 0

    @clocked_ins = User.clocked_ins

    respond_to do |format|
      format.html
    end
  end

  def create
    delivery = Delivery.create({:listing_user => current_user})
    redirect_to :action => :edit, :id => delivery.id
  end

  def show
    @delivery = Delivery.find(params[:id])
  end

  def edit
    @delivery = Delivery.find(params[:id])
    unless @delivery && @delivery.available_for_edit_by(current_user)
      flash[:error] = "Not allowed to edit delivery #{params[:id]}"
      redirect_to root_path
    end
  end

  def update
    # update form is also a creation form for the dependent models
    delivery = Delivery.find(params[:id])
    unless delivery && delivery.available_for_edit_by(current_user)
      flash[:error] = "Not allowed to edit delivery #{params[:id]}"
      redirect_to root_path
      return
    end
    delivery.apply_form_attributes(params[:delivery])
    
    fee = Fee.new
    fee.apply_form_attributes(params[:fee])
    fee.save!
    delivery.fee = fee

    package = Package.new
    package.apply_form_attributes(params[:package])
    package.save!
    delivery.package = package

    location = Location.new
    location.apply_form_attributes(params[:from])
    location.save!
    delivery.start_location = location

    location = Location.new
    location.apply_form_attributes(params[:to])
    location.save!
    delivery.end_location = location

    delivery.save!
    redirect_to delivery_path(delivery)
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    redirect_to :controller => :users, :action => :show, :id => delivery.listing_user.username
  end

  def accept
    delivery = Delivery.find(params[:id].to_i)
    delivery.deliverer(current_user)
    delivery.save!
    Mailer.deliver_delivery_accepted(delivery)
    Journal.create({:delivery => delivery, :user => delivery.listing_user, :note => "emailed delivery accepted letter"})
    flash[:notice] = "Delivery accepted!"
    redirect_to delivery_path(delivery)
  end
end
