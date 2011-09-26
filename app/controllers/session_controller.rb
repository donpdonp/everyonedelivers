class SessionController < ApplicationController

  def login_token
    user = User.find_by_authentication_token(params[:token])
    if user
      logger.info("session: #{session.inspect}")
      sign_in user
      logger.info("session after login: #{session.inspect}")
      if session[:anonymous_delivery_id]
        delivery = Delivery.find(session[:anonymous_delivery_id])
        redirect_to edit_delivery_path(delivery)
      else
        redirect_to :deliveries
      end
    else
      flash[:error] = "The login link is not valid. Please login with your email address to get a new link."
      redirect_to :root
    end
  end

  def login
    # email validation
    unless params[:email][/.@./]
      flash[:error] = "Please use an email address."
      redirect_to :root
      return      
    end
    user = User.find_by_email(params[:email])
    unless user
      logger.info "creating user #{params}"
      user = User.create_with_defaults!(:email => params[:email])
    end
    logger.info "sending login email to #{user.email}"
    UserMailer.login_token_email(user).deliver
    flash[:notice] = "Login instructions sent to #{user.email}."
    redirect_to :deliveries
  end

  def logout
    reset_session
    flash[:notice] = "logged out"
    redirect_to :root
  end

end
