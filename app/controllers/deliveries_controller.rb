class DeliveriesController < ApplicationController
  before_filter :load_resource, :except => [:index, :create]

  def index
    @delivery_groups = [ ]
    if params[:q]
      # postgresql full-text search
      one_month = Delivery.all(:conditions => ["to_tsvector('english', packages.description) "+
                                               "@@ to_tsquery('english', ?)", params[:q]], :include => :package)
      flash[:notice] = "Search results for \"#{params[:q]}\""                                               
    else
      now = Time.now
      one_month = Delivery.waitings.find_due_after_time(now) + 
                  Delivery.waitings.find_due_between_times(1.month.ago, now)
    end
    @delivery_groups << ["less than a month old", one_month] if one_month.size > 0
    #four_hours = Delivery.find_between_hours_old(1,4).select{|d| d.ok_to_display?}
    #@delivery_groups << ["one to four hours old", four_hours] if four_hours.size > 0
    #many_hours = Delivery.find_more_than_hours_old(4).select{|d| d.ok_to_display?}
    #@delivery_groups << ["more than four hours old", many_hours] if many_hours.size > 0

    @clocked_ins = User.clocked_ins
  end

  def create
    delivery = Delivery.create({:listing_user => current_user})
    session[:anonymous_delivery_id] = delivery.id unless user_signed_in?
    redirect_to edit_delivery_path(delivery)
  end

  def show
  end

  def edit
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
      if @delivery.id == session[:anonymous_delivery_id]
        logger.info("editing under anonymous_delivery_id")
      else
        flash[:error] = "Login to edit a delivery request."
        redirect_to root_path          
      end
    end
  end

  def update
    # update form is also a creation form for the dependent models
    unless (params[:id].to_i == session[:anonymous_delivery_id]) || 
            @delivery.available_for_edit_by(current_user)
      flash[:error] = "Not allowed to edit delivery #{params[:id]}"
      redirect_to root_path
      return
    end
    @delivery.apply_form_attributes(params[:delivery])
    
    fee = Fee.new
    fee.apply_form_attributes(params[:fee])
    fee.save!
    @delivery.fee = fee

    package = Package.new
    package.apply_form_attributes(params[:package])
    package.save!
    @delivery.package = package

    location = Location.new
    location.apply_form_attributes(params[:from])
    location.save!
    @delivery.start_location = location

    location = Location.new
    location.apply_form_attributes(params[:to])
    location.save!
    @delivery.end_location = location

    if @delivery.save
      if @delivery.listing_user
        redirect_to delivery_path(@delivery)
      else
        redirect_to :controller => :dashboard, :action => :start_delivery
      end
    else
      redirect_to edit_delivery_path(@delivery)
    end
  end

  def destroy
    @delivery.destroy
    redirect_to :deliveries
  end

  def confirm
  end

  def accept
    if params["commit"]=="Yes I accept"
      if @delivery.accepted?
        flash[:error] = "Delivery has already been accepted!"
      end
      if @delivery.waiting?
        @delivery.deliverer(current_user)
        @delivery.save!
        @delivery.accept!
        DeliveryMailer.accepted(@delivery).deliver
        Journal.create({:delivery => @delivery, :user => @delivery.listing_user, :note => "emailed delivery accepted letter"})
        flash[:notice] = "Delivery accepted!"
      end
      if @delivery.building?
        flash[:error] = "Delivery is not ready yet!"
      end
    end
    redirect_to delivery_path(@delivery)
  end

  def comment
    @delivery.comments.create(:text => params[:comment][:text],
                              :user_id => current_user.id)    
    redirect_to @delivery
  end

  def comment_delete
    @delivery.comments.find(params[:comment_id]).destroy
    redirect_to @delivery
  end

  private
  def load_resource
    @delivery = Delivery.find(params[:id])
    unless @delivery
      flash[:error] = "Delivery ##{params[:id]} does not exist."
      redirect_to :deliveries
    end
  end
end
