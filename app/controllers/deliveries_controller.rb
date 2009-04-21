class DeliveriesController < ApplicationController
  def index
    @deliveries = Delivery.all
    respond_to do |format|
      format.html
    end
  end

end
