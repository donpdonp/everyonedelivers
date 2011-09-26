class DeliveriesController < ApplicationController
  def index
    @delivery_groups = [ ]
    if params[:q]
      one_month = Delivery.all(:conditions => ["to_tsvector('english', packages.description) @@ to_tsquery('english', ?)", "living"], :include => :package) # Postgresql specific
    else
      one_month = Delivery.waitings.find_at_most_hours_old(24*31)
    end
    one_month = one_month.sort{|a,b| b.fee.delivery_due <=> a.fee.delivery_due}
    @delivery_groups << ["less than a month old", one_month] if one_month.size > 0
    #four_hours = Delivery.find_between_hours_old(1,4).select{|d| d.ok_to_display?}
    #@delivery_groups << ["one to four hours old", four_hours] if four_hours.size > 0
    #many_hours = Delivery.find_more_than_hours_old(4).select{|d| d.ok_to_display?}
    #@delivery_groups << ["more than four hours old", many_hours] if many_hours.size > 0

    @clocked_ins = User.clocked_ins

    respond_to do |format|
      format.html
    end
  end

  def create
    delivery = Delivery.create({:listing_user => current_user})
    session[:anonymous_delivery_id] = delivery.id unless user_signed_in?
    redirect_to edit_delivery_path(delivery)
  end

  def show
    @delivery = Delivery.find(params[:id])
  end

  def edit
    @delivery = Delivery.find(params[:id])
    logger.info("params[:id] = #{params[:id].inspect}  session = #{session.inspect}")
    if @delivery 
      if user_signed_in?
        if @delivery.listing_user.nil?
          if params[:id].to_i == session[:anonymous_delivery_id]
            flash[:notice] = "Thank you for logging in. Please review the delivery before saving."
            session[:anonymous_delivery_id] = nil
            logger.info("assigning formerly anonymous listing")
            @delivery.listing_user = current_user
            @delivery.save!
          else
            flash[:error] = "Delivery ##{@delivery.id} was not started with this browser."
            redirect_to root_path
          end
        else
          unless @delivery.available_for_edit_by(current_user)
            flash[:error] = "Not allowed to edit delivery #{params[:id]}"
            redirect_to root_path
          end
        end
      else
        if params[:id].to_i == session[:anonymous_delivery_id]
          logger.info("editing under anonymous_delivery_id")
        else
          flash[:error] = "Login to edit a delivery request."
          redirect_to root_path          
        end
      end

    else 
      flash[:error] = "Delivery #{params[:id]} not found"
      redirect_to :deliveries
    end
  end

  def update
    # update form is also a creation form for the dependent models
    delivery = Delivery.find(params[:id])
    logger.info("#{delivery} #{params[:id].inspect} #{session[:anonymous_delivery_id].inspect}")
    unless delivery && ((params[:id].to_i == session[:anonymous_delivery_id]) || delivery.available_for_edit_by(current_user))
      flash[:error] = "Not allowed to edit delivery #{params[:id]}"
      redirect_to root_path
      return
    end
    delivery.apply_form_attributes(params[:delivery])
    
    fee = Fee.new
    fee.apply_form_attributes(params[:fee])
    fee.save!
    delivery.fee = fee

    package = Package.new
    package.apply_form_attributes(params[:package])
    package.save!
    delivery.package = package

    location = Location.new
    location.apply_form_attributes(params[:from])
    location.save!
    delivery.start_location = location

    location = Location.new
    location.apply_form_attributes(params[:to])
    location.save!
    delivery.end_location = location

    delivery.save!

    if delivery.listing_user
      redirect_to delivery_path(delivery)
    else
      redirect_to :controller => :dashboard, :action => :start_delivery
    end
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    redirect_to deliveries_path
  end

  def confirm
    @delivery = Delivery.find(params[:id])
  end

  def accept
    if params["commit"]=="Yes I accept"
      delivery = Delivery.find(params[:id].to_i)
      if delivery.accepted?
        flash[:error] = "Delivery has already been accepted!"
      end
      if delivery.waiting?
        delivery.deliverer(current_user)
        delivery.save!
        delivery.accept!
        Mailer.deliver_delivery_accepted(delivery)
        Journal.create({:delivery => delivery, :user => delivery.listing_user, :note => "emailed delivery accepted letter"})
        flash[:notice] = "Delivery accepted!"
      end
      if delivery.building?
        flash[:error] = "Delivery is not ready yet!"
      end
    end
    redirect_to delivery_path(delivery)
  end
end
