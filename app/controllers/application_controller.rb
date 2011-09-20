class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user, :logged_in?
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_timezone

  def set_timezone
    # current_user.time_zone #=> 'London'
    Time.zone = current_user.time_zone if current_user
  end
end
