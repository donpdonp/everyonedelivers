require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DeliveriesController do

  context "when logged in" do
    before(:each) do 
      controller.stub!(:user_signed_in?).and_return(true)
      @user = mock_model(User)
      controller.stub!(:current_user).and_return(@user)
      controller.stub!(:set_timezone)
    end

    it "lists deliveries" do
      get :index
    end

    it "creates a delivery" do
      delivery = mock_model(Delivery)
      Delivery.should_receive(:create).and_return(delivery)
      post :create
      response.should redirect_to(edit_delivery_path(delivery))
    end

    it "shows the details of a delivery" do
      delivery = mock_model(Delivery)
      Delivery.should_receive(:find).and_return(delivery)
      get :show, {:id => delivery.id}
      response.should render_template("show")
    end

    it "edits a delivery" do
      delivery = mock_model(Delivery)
      Delivery.should_receive(:find).and_return(delivery)
      delivery.should_receive(:listing_user).and_return(mock_model(User))
      delivery.should_receive(:available_for_edit_by).with(@user).and_return(true)
      get :edit, {:id => delivery.id}
      response.should render_template("edit")
    end

    context "updates a delivery" do
      before(:each) do
        bob = mock_model(User)
        #bob.should_receive(:username).and_return("bob")
        @delivery = mock_model(Delivery)
        @delivery.should_receive(:fee=)
        @delivery.should_receive(:package=)
        @delivery.should_receive(:start_location=)
        @delivery.should_receive(:end_location=)
        @delivery.should_receive(:save).and_return(true)
        @delivery.should_receive(:apply_form_attributes)
        Delivery.should_receive(:find).and_return(@delivery)
      end

      it "when the delivery has a creator" do
        @delivery.should_receive(:available_for_edit_by).with(@user).and_return(true)
        @delivery.should_receive(:listing_user).and_return(@user)
        put :update, {:id => @delivery.id}
        response.should redirect_to(delivery_path(@delivery))
      end

      it "when the delivery was created anonymously" do
        @delivery.should_receive(:listing_user)
        session[:anonymous_delivery_id] = @delivery.id
        put :update, {:id => @delivery.id}
        response.should redirect_to(:controller => :dashboard, :action => :start_delivery)
      end
    end

    it "should destroy a delivery" do
      delivery = mock_model(Delivery)
      delivery.should_receive(:destroy)
      Delivery.should_receive(:find).and_return(delivery)
      delete :destroy
      response.should redirect_to(deliveries_path)
    end

    it "should accept a delivery" do
      bob = mock_model(User)
      lister = mock_model(User)
      delivery = mock_model(Delivery)
      delivery.should_receive(:building?).and_return(false)
      delivery.should_receive(:accepted?).and_return(false)
      delivery.should_receive(:waiting?).and_return(true)
      delivery.should_receive(:deliverer).with(@user)
      delivery.should_receive(:save!)
      delivery.should_receive(:accept!)
      delivery.should_receive(:listing_user).and_return(bob)
      mailer = mock("Delivery Mailer")
      mailer.should_receive(:deliver)
      DeliveryMailer.should_receive(:accepted).with(delivery).and_return(mailer)
      Delivery.should_receive(:find).with(delivery.id.to_s).and_return(delivery)
      put :accept, {:id => delivery.id, "commit"=>"Yes I accept"}
      response.should redirect_to(delivery_path(delivery))
    end
  end

  context "when logged out" do
    before(:each) do 
      controller.stub!(:user_signed_in?).and_return(false)
      controller.stub!(:current_user)
      controller.stub!(:set_timezone)
    end

    it "edits a delivery" do
      delivery = mock_model(Delivery)
      Delivery.should_receive(:find).and_return(delivery)
      session[:anonymous_delivery_id] = delivery.id
      get :edit, {:id => delivery.id}
      response.should render_template("edit")
    end


    it "should update a delivery" do
      bob = mock_model(User)
      #bob.should_receive(:username).and_return("bob")
      delivery = mock_model(Delivery)
      delivery.should_receive(:available_for_edit_by).with(@user).and_return(true)
      delivery.should_receive(:fee=)
      delivery.should_receive(:package=)
      delivery.should_receive(:start_location=)
      delivery.should_receive(:end_location=)
      delivery.should_receive(:save).and_return(true)
      delivery.should_receive(:apply_form_attributes)
      delivery.should_receive(:listing_user).and_return(nil)
      Delivery.should_receive(:find).and_return(delivery)
      put :update, {:id => delivery.id}
      response.should redirect_to(:controller => :dashboard, :action => :start_delivery)
    end
  end
end
