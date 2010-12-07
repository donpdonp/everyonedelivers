class DashboardController < ApplicationController

  def index
    @featured_delivery = Delivery.first(:conditions => {:featured => true})
  end

  def start_delivery
  end

  def ready_delivery
    redirect_to :action => :start_delivery unless logged_in?
  end
end
