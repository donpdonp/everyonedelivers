require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DeliveriesController do

  before(:each) do 
    controller.stub!(:logged_in?).and_return(true)
    @user = mock_model(User)
    controller.stub!(:current_user).and_return(@user)
    controller.stub!(:set_timezone)
  end

  it "should list deliveries" do
    get :index
  end

  it "create a delivery" do
    delivery = mock_model(Delivery)
    Delivery.should_receive(:create).and_return(delivery)
    post :create
    response.should redirect_to(edit_delivery_path(delivery))
  end

  it "should show the details of a delivery" do
    delivery = mock_model(Delivery)
    Delivery.should_receive(:find).and_return(delivery)
    get :show, {:id => delivery.id}
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
    delivery.should_receive(:save!)
    delivery.should_receive(:apply_form_attributes)
    delivery.should_receive(:listing_user).and_return(@user)
    Delivery.should_receive(:find).and_return(delivery)
    put :update, {:id => delivery.id}
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
    Mailer.should_receive(:deliver_delivery_accepted).with(delivery)
    Delivery.should_receive(:find).with(delivery.id).and_return(delivery)
    put :accept, {:id => delivery.id, "commit"=>"Yes I accept"}
  end
end
