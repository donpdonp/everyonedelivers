# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user, :logged_in?
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_timezone

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  include LoginSystem

  def set_timezone
    # current_user.time_zone #=> 'London'
    Time.zone = current_user.time_zone
  end
end
