module LoginSystem
  protected
  def self.included(base)
    base.send :helper_method, :logged_in?, :current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    User.find_by_id(session[:openid])
  end

  def current_user=(user)
    case user
    when Fixnum
      session[:openid] = user
    when User
      session[:openid] = user.id
    end
    logger.info("logged in #{session[:openid]}")
  end

  def login_required
    authorized? || access_denied
  end

  def authorized?
    logged_in?
  end

  def access_denied
    respond_to do |format|
      format.html do
        flash[:alert] = "Please login first"
        # ruby 1.8 hack, select does not return a hash
        oauth_extras = params.reject{|k,v| !k.match(/^oauth/)}
        next_url = request.request_uri
        next_url = url_for({:controller => :oauth, :action => :authorize}.merge(oauth_extras)) if oauth_extras.keys.size > 0
        redirect_to :controller => :session, :action => :login_screen, :next_url => next_url
      end
      format.any(:json, :xml) do
        request_http_basic_authentication 'Web Password'
      end
    end
  end
end
