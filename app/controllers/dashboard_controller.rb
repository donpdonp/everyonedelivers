class DashboardController < ApplicationController

  def index
    @deliveries = Delivery.all # to populate the deliveries/list partiel
  end
end
