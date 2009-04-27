class UsersController < ApplicationController
  before_filter :logged_in?, :only => [:show]
end
