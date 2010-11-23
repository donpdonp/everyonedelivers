class DashboardController < ApplicationController

  def index
    if logged_in?
      redirect_to deliveries_path
      return
    end

    @featured_delivery = Delivery.first(:conditions => {:featured => true})
  end

end
