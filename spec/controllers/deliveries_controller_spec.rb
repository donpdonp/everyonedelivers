require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DeliveriesController do

  #Delete this example and add some real ones
  it "should use DeliveriesController" do
    controller.should be_an_instance_of(DeliveriesController)
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

end
