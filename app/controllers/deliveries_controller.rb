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
    delivery = Delivery.find(params[:id])
    delivery.apply_form_attributes(params[:delivery])
    delivery.save!
    redirect_to :action => :edit, :id => delivery.id
  end
end
