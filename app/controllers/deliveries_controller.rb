class DeliveriesController < ApplicationController
  before_filter :login_required, :only => [:create, :edit, :update]

  def index
    @deliveries = Delivery.all
    respond_to do |format|
      format.html
    end
  end

  def create
    delivery = Delivery.create({:listing_user => current_user})
    redirect_to :action => :edit, :id => delivery.id
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    # update form is also a creation form for the dependent models
    delivery = Delivery.find(params[:id])
    
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
    redirect_to :action => :edit, :id => delivery.id
  end
end
