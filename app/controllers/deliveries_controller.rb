class DeliveriesController < ApplicationController
  def index
    @deliveries = Delivery.all
    respond_to do |format|
      format.html
    end
  end

  def create
    delivery = Delivery.create
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

    delivery.save!
    redirect_to :action => :edit, :id => delivery.id
  end
end
