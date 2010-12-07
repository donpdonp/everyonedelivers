class SessionController < ApplicationController
  include OpenidUtility

  def login
    begin
      params[:openid_identifier]
      identifier = email_to_openid_filter(params[:openid_identifier])
      if identifier.nil?
        flash[:error] = "Enter an OpenID identifier"
        redirect_to :root
        return
      end
      oidreq = consumer.begin(identifier)
      axr = OpenID::AX::FetchRequest.new
      axr.add(OpenID::AX::AttrInfo.new("http://axschema.org/contact/email", "email", true))
      axr.add(OpenID::AX::AttrInfo.new("http://axschema.org/namePerson/friendly", "username", true))
      oidreq.add_extension(axr)
    rescue OpenID::OpenIDError => e
      flash[:error] = "Discovery failed for #{identifier}: #{e}"
      redirect_to :root
      return
    end
    return_to = url_for :action => 'complete', :only_path => false, :next_url => params[:next_url]
    realm = root_url

    if oidreq.send_redirect?(realm, return_to, params[:immediate])
      redirect_to oidreq.redirect_url(realm, return_to, params[:immediate])
    else
      render :text => oidreq.html_markup(realm, return_to, params[:immediate], {'id' => 'openid_form'})
    end
  end

  def complete
    # FIXME - url_for some action is not necessarily the current URL.
    current_url = url_for(:action => 'complete', :only_path => false)
    parameters = params.reject{|k,v|request.path_parameters[k]}
    oidresp = consumer.complete(parameters, current_url)
    case oidresp.status
    when OpenID::Consumer::FAILURE
      if oidresp.display_identifier
        flash[:error] = ("Verification of #{oidresp.display_identifier}"\
                         " failed: #{oidresp.message}")
      else
        flash[:error] = "Verification failed: #{oidresp.message}"
      end
    when OpenID::Consumer::SUCCESS
      flash[:success] = ("Verification of #{oidresp.display_identifier}"\
                         " succeeded.")
      # simple registration
      ax_resp = OpenID::AX::FetchResponse.from_success_response(oidresp)
      hints = {:email => "", :username => ""}
      if ax_resp
        hints[:email] = ax_resp.get_single("http://axschema.org/contact/email") 
        hints[:username] = ax_resp.get_single("http://axschema.org/namePerson/friendly")
      end
      openid = Openidentity.lookup(oidresp.display_identifier)
      if openid
        user = openid.user
      else
        user = Openidentity.create_openid_and_user_with_url(oidresp.display_identifier, hints).user
        params[:next_url] = url_for(:controller => :users, :action => :edit, :id => user.username,
                                    :next_url => params[:next_url])
        flash[:notice] = "Welcome new user."
        unless user.email.blank?
          Mailer.deliver_signup_notification(user)
          Journal.create({:delivery => nil, :user => user, :note => "emailed signup welcome letter"})
        end
      end
      self.current_user = user
    when OpenID::Consumer::SETUP_NEEDED
      flash[:alert] = "Immediate request failed - Setup Needed"
    when OpenID::Consumer::CANCEL
      flash[:alert] = "OpenID transaction cancelled."
    else
    end
    if session[:anonymous_delivery_id]
      delivery = Delivery.find_by_id(session[:anonymous_delivery_id])
      session[:anonymous_delivery_id] = nil
      if delivery
        delivery.listing_user = current_user
        delivery.save!
        redirect_to delivery
      else
        redirect_to root_path
      end
    else
      redirect_to (params[:next_url] || deliveries_path)
    end
  end

  def logout
    reset_session
    flash[:notice] = "logged out"
    redirect_to :root
  end

end
