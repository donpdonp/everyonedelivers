class SessionController < ApplicationController

  def login_token
    user = User.find_by_authentication_token(params[:token])
    if user
      logger.info("session: #{session.inspect}")
      sign_in user
      logger.info("session after login: #{session.inspect}")
      if session[:anonymous_delivery_id]
        delivery = Delivery.find(session[:anonymous_delivery_id])
        session[:anonymous_delivery_id] = nil
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
    user = User.find_by_email(params[:email])
    unless user
      logger.info "creating user #{params}"
      user = User.create!(:username => params[:email], :email => params[:email],
                          :authentication_token => UUIDTools::UUID.random_create.to_s)
    end
    logger.info "sending login email to #{user.email}"
    UserMailer.login_token_email(user).deliver
    flash[:notice] = "Login email sent to #{user.email}."
    redirect_to :root
  end

  def logout
    reset_session
    flash[:notice] = "logged out"
    redirect_to :root
  end

end
