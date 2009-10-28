class DashboardController < ApplicationController

  def index
    if logged_in?
      redirect_to deliveries_path
    end
  end

end
