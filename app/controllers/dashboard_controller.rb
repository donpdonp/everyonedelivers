class DashboardController < ApplicationController

  def index
    @delivery_groups = [ ]
    one_hour = Delivery.find_at_most_hours_old(1).select{|d| d.ok_to_display?}
    @delivery_groups << ["less than an hour old", one_hour] if one_hour.size > 0
    four_hours = Delivery.find_between_hours_old(1,4).select{|d| d.ok_to_display?}
    @delivery_groups << ["one to four hours old", four_hours] if four_hours.size > 0
    many_hours = Delivery.find_more_than_hours_old(4).select{|d| d.ok_to_display?}
    @delivery_groups << ["more than four hours old", many_hours] if many_hours.size > 0

    @clocked_ins = User.all(:conditions => {:clocked_in => true})
  end

end
